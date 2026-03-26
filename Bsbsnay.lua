-- ==========================================================
-- VALKEY / REDIS LUA SCRIPT (Deep Guide)
-- File: valkey_manager.lua
-- Is script ko 'EVAL' command ke saath run kiya jata hai.
-- ==========================================================

-- 1. KEYS AUR ARGV SAMJHNA
-- Lua mein KEYS[1], KEYS[2]... wo keys hain jo aap bhejte hain.
-- ARGV[1], ARGV[2]... wo values hain jo variable data ke liye hoti hain.

local userKey = KEYS[1]            -- Example: "user:123:profile"
local rateLimitKey = KEYS[2]       -- Example: "user:123:requests"
local newScore = ARGV[1]           -- Example: "500"
local expireTime = ARGV[2]         -- Example: "60" (seconds)


-- 2. GET DATA (Valkey se data nikalna)
-- redis.call('COMMAND', 'KEY_NAME')
local currentStatus = redis.call('GET', userKey)

-- Checking if data exists
if not currentStatus then
    currentStatus = "New User"
end


-- 3. RATE LIMITING LOGIC (Ek common use case)
-- Hum check karenge ki user ne kitni baar request ki hai.
local currentRequests = redis.call('INCR', rateLimitKey)

if tonumber(currentRequests) == 1 then
    -- Agar pehli baar hai, toh expiry set karo (e.g., 60 seconds)
    redis.call('EXPIRE', rateLimitKey, expireTime)
end


-- 4. CONDITIONAL LOGIC (Sirf tab update karo agar limit ke andar ho)
local resultMessage = ""

if tonumber(currentRequests) > 10 then
    -- Agar 10 se zyada requests hain, toh block kar do
    resultMessage = "Limit Exceeded! Try again later."
else
    -- Agar limit ke andar hai, toh profile update karo (HSET use kar rahe hain)
    redis.call('HSET', userKey, "score", newScore, "last_active", "now")
    resultMessage = "Profile Updated Successfully!"
end


-- 5. MULTIPLE OPERATIONS (Atomic Nature)
-- Yahan hum ek hi script mein do alag keys update kar rahe hain.
-- Ye guarantee hai ki dono ya toh honge, ya ek bhi nahi (Atomic).
redis.call('PUBLISH', 'log_channel', "User updated: " .. userKey)


-- 6. RETURN VALUE (Script ka output)
-- Hamesha string ya table return karein jo client-side par receive hoga.
return {
    "Status: " .. currentStatus,
    "Requests Done: " .. currentRequests,
    "Message: " .. resultMessage
}

-- ==========================================================
-- ISKO CHALAYEIN KAISE? (Valkey-cli command)
-- ==========================================================
-- Command structure:
-- EVAL "script_content" [Number of Keys] [Key1] [Key2] [Arg1] [Arg2]
--
-- Example:
-- EVAL "return redis.call('SET', KEYS[1], ARGV[1])" 1 mykey myvalue

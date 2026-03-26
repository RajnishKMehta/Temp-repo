-- ==========================================================
-- LUA MASTER SCRIPT (Hinglish Guide)
-- File: learning_guide.lua
-- ==========================================================

-- 1. VARIABLES AUR DATA TYPES
-- Lua mein variables by default 'global' hote hain, lekin 'local' use karna best practice hai.
local name = "Rajnish"          -- String
local age = 21                  -- Number
local isDeveloper = true        -- Boolean
local emptyValue = nil          -- Nil (Null jaisa)

print("--- Variables Section ---")
print("Name: " .. name) -- '..' ka use do strings ko jodne (concatenate) ke liye hota hai.


-- 2. TABLES (Sabse important part: Yeh Array aur Object dono ka kaam karta hai)
local skills = {"Node.js", "TypeScript", "Lua", "Rust"} -- Indexed Table (Array)
local userProfile = {                                  -- Key-Value Table (Object)
    username = "RajnishKMehta",
    role = "Developer",
    status = "Active"
}

print("Pehla Skill: " .. skills[1]) -- Lua mein indexing 1 se shuru hoti hai (0 se nahi).


-- 3. FUNCTIONS
-- Ek simple function jo greeting return karta hai.
local function greetUser(uName)
    return "Namaste, " .. uName .. "!"
end

local message = greetUser(userProfile.username)
print(message)


-- 4. CONDITIONALS (If-Else)
print("--- Logic Check ---")
if age >= 18 then
    print("Aap adult hain.")
elseif age > 12 then
    print("Aap teenager hain.")
else
    print("Aap bacche hain.")
end


-- 5. LOOPS (Iterating data)
print("--- Loops Section ---")

-- For Loop: 1 se 3 tak chalega
for i = 1, 3 do
    print("Loop Number: " .. i)
end

-- Pairs Loop: Table ke andar ki har cheez print karne ke liye
for key, value in pairs(userProfile) do
    print(key .. ": " .. value)
end


-- 6. MATH AUR LOGIC
local a = 10
local b = 5
print("Addition: " .. (a + b))
print("Power: " .. (a ^ 2)) -- 10 ki power 2 = 100


-- 7. ERROR HANDLING (Advanced)
-- 'pcall' (protected call) ka use hota hai taaki script crash na ho agar error aaye.
local status, err = pcall(function()
    -- Maan lo yahan koi aisi cheez hai jo error degi
    return 10 + "string" 
end)

if not status then
    print("Error pakda gaya: " .. err)
end


-- 8. MODULES (Code ko organize karna)
-- Aap ek table bana kar usme functions daal sakte hain
local MyTools = {}

function MyTools.sayBye()
    print("Alvida! Agli baar milte hain.")
end

MyTools.sayBye()

-- ==========================================================
-- END OF SCRIPT
-- ==========================================================

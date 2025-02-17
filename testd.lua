-- Deobfuscator for Protego v0.4-DEV

-- Function to decode obfuscated strings
local function decodeString(encoded)
    return (encoded:gsub("\\(%d+)", function(n)
        return string.char(tonumber(n))
    end))
end

-- Function to remove obfuscation comments
local function removeComments(code)
    return (code:gsub("%-%-%[%[.-%]%]", ""))
end

-- Function to restore variable names (example mapping)
local function restoreVariableNames(code)
    local variableMapping = {
        ["IlllIllIIIIllllIIl"] = "originalVariableName1",
        ["lIIIIIllII"] = "originalVariableName2",
        -- Add more mappings as needed
    }
    for obfuscated, original in pairs(variableMapping) do
        code = code:gsub(obfuscated, original)
    end
    return code
end

-- Main deobfuscation function
local function deobfuscate(code)
    code = decodeString(code)
    code = removeComments(code)
    code = restoreVariableNames(code)
    return code
end

-- Function to read a file
local function readFile(filePath)
    local file = io.open(filePath, "r")
    if not file then
        error("Could not open file: " .. filePath)
    end
    local content = file:read("*all")
    file:close()
    return content
end

-- Function to write to a file
local function writeFile(filePath, content)
    local file = io.open(filePath, "w")
    if not file then
        error("Could not open file: " .. filePath)
    end
    file:write(content)
    file:close()
end

-- Main script
local inputFilePath = "out.lua"
local outputFilePath = "deobfuscated.lua"

local obfuscatedCode = readFile(inputFilePath)
local deobfuscatedCode = deobfuscate(obfuscatedCode)
writeFile(outputFilePath, deobfuscatedCode)

print("Deobfuscation complete. Output written to " .. outputFilePath)
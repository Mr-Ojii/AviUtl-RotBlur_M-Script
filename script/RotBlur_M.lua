local RotBlur_M = {}

-- define local function
local function script_path()
    return debug.getinfo(1).source:match("@?(.*[/\\])")
end

local function rot_mat(angle)
    return { math.cos(angle), -math.sin(angle), math.sin(angle), math.cos(angle) }
end
----

local GLShaderKit = require "GLShaderKit"

local shader_path = script_path().."RotBlur_M.frag"

if GLShaderKit.isInitialized() then
    RotBlur_M.RotBlur_M = function(x, y, amount, r_pos, keep_size, quality, reload)

        local data, w, h
        w, h = obj.getpixel()
        local r = math.sqrt(w * w + h * h)
        if not keep_size then
            local addX, addY = math.ceil((r - w) / 2 + 1), math.ceil((r - h) / 2 + 1)
            obj.effect("領域拡張", "上", addY, "下", addY, "右", addX, "左", addX)
        end

        if amount == 0 then
            return
        end

        data, w, h = obj.getpixeldata()

        GLShaderKit.activate()
        GLShaderKit.setPlaneVertex(1)
        GLShaderKit.setShader(shader_path, reload)
        GLShaderKit.setFloat("resolution", w, h)
        GLShaderKit.setFloat("pivot", x + w * 0.5, y + h * 0.5)
        GLShaderKit.setMatrix("rPos", "2x2", false, rot_mat(amount * r_pos))
        local rMat = rot_mat(amount / quality)
        GLShaderKit.setMatrix("rot1", "2x2", false, rMat)
        GLShaderKit.setMatrix("rot2", "2x2", true, rMat)
        GLShaderKit.setInt("quality", quality)
        GLShaderKit.setTexture2D(0, data, w, h)
        GLShaderKit.draw("TRIANGLES", data, w, h)

        GLShaderKit.deactivate()

        obj.putpixeldata(data)
    end
else
    RotBlur_M.RotBlur_M = function(x, y, amount, r_pos, keep_size, quality, reload)
        obj.setfont("MS UI Gothic", amount + 30)
        obj.load("text", "RotBlur_M is not available on this device.\nRotBlur_Mはこのデバイスでは使用できません。")
        obj.draw()
    end
end

return RotBlur_M
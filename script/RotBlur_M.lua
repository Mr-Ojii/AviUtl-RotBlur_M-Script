local RotBlur_M = {}

RotBlur_M.RotBlur_M = function(x, y, amount, r_pos, keep_size, quality, reload)

    -- define local function
    local function script_path()
        return debug.getinfo(1).source:match("@?(.*[/\\])")
    end

    local function rot_mat(angle)
        return { math.cos(angle), -math.sin(angle), math.sin(angle), math.cos(angle) }
    end
    ----

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

    local GLShaderKit = require "GLShaderKit"

    local shader_path = script_path().."RotBlur_M.frag"

    data, w, h = obj.getpixeldata()

    if GLShaderKit.isInitialized() then
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
    else
        obj.setfont("MS UI Gothic", obj.track2 + 30)
        obj.load("text", "RotBlur_M is not available on this device.\nRotBlur_Mはこのデバイスでは使用できません。")
        obj.draw()
    end

    obj.putpixeldata(data)

end

return RotBlur_M
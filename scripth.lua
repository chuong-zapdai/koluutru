-- Script tự động bay đến và nhặt rương
local UIS = game:GetService("UserInputService")
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Thiết lập ScreenGui
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Thiết lập ToggleButton
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 80, 0, 80) -- Kích thước hình tròn nhỏ hơn
ToggleButton.Position = UDim2.new(0, 10, 0, 10) -- Vị trí góc trái màn hình
ToggleButton.Text = "Tắt"
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextScaled = true -- Để chữ tự động điều chỉnh kích thước
ToggleButton.AutoButtonColor = false -- Tắt hiệu ứng màu nút khi nhấn
ToggleButton.BorderSizePixel = 0 -- Xóa đường viền

-- Thiết lập UICorner để tạo hình tròn
UICorner.Parent = ToggleButton
UICorner.CornerRadius = UDim.new(1, 0) -- Thiết lập bán kính góc để tạo thành hình tròn

-- Biến kiểm soát tự động nhặt rương
local autoCollect = false

-- Hàm bật/tắt tự động nhặt rương
local function toggleAutoCollect()
    autoCollect = not autoCollect
    ToggleButton.Text = autoCollect and "Bật" or "Tắt"
end

ToggleButton.MouseButton1Click:Connect(toggleAutoCollect)

-- Hàm tự động bay đến và nhặt rương
game:GetService("RunService").RenderStepped:Connect(function()
    if autoCollect then
        for _, chest in pairs(game.Workspace:GetDescendants()) do
            if chest.Name == "Chest" and chest:IsA("Model") and chest:FindFirstChild("ProximityPrompt") then
                -- Di chuyển đến vị trí của rương
                wait(0.1) -- Thêm thời gian chờ
                HumanoidRootPart.CFrame = chest.PrimaryPart.CFrame + Vector3.new(0, 3, 0) -- Bay trên rương 3 đơn vị
                wait(0.5) -- Đợi để đảm bảo prompt đã tải
                -- Kích hoạt nhặt rương
                fireproximityprompt(chest.ProximityPrompt)
            end
        end
    end
end)

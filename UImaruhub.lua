-- Banana Cat Hub - Custom UI Interface (Delta Compatible)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Xóa UI cũ nếu đã chạy trước đó
if CoreGui:FindFirstChild("BananaCatHubUI") then
    CoreGui.BananaCatHubUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BananaCatHubUI"
ScreenGui.Parent = (gethui and gethui()) or CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Bảng màu chuẩn theo ảnh
local BG_COLOR = Color3.fromRGB(15, 15, 17)
local PANEL_COLOR = Color3.fromRGB(22, 22, 25)
local ITEM_COLOR = Color3.fromRGB(28, 28, 32)
local ACCENT_COLOR = Color3.fromRGB(250, 190, 20) -- Vàng chuẩn Banana Cat
local TEXT_COLOR = Color3.fromRGB(240, 240, 240)
local SUBTEXT_COLOR = Color3.fromRGB(150, 150, 155)

-- Khung chính (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 580, 0, 340)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -170)
MainFrame.BackgroundColor3 = BG_COLOR
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = MainFrame

-- Kéo thả Menu (Drag System)
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Thanh Tiêu đề (Top Bar)
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 32)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, 0, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Banana Cat Hub  -  Blox Fruit"
TitleText.TextColor3 = ACCENT_COLOR
TitleText.TextSize = 14
TitleText.Font = Enum.Font.SourceSansBold
TitleText.Parent = TitleBar

-- Cột bên trái (Sidebar)
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 190, 1, -40)
Sidebar.Position = UDim2.new(0, 8, 0, 32)
Sidebar.BackgroundColor3 = PANEL_COLOR
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 5)
SidebarCorner.Parent = Sidebar

-- Ô Tìm kiếm Tab (Search Box)
local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(1, -12, 0, 26)
SearchFrame.Position = UDim2.new(0, 6, 0, 6)
SearchFrame.BackgroundColor3 = BG_COLOR
SearchFrame.BorderSizePixel = 0
SearchFrame.Parent = Sidebar

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 4)
SearchCorner.Parent = SearchFrame

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -10, 1, 0)
SearchBox.Position = UDim2.new(0, 6, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.PlaceholderText = "🔍 Search section or Fun"
SearchBox.PlaceholderColor3 = SUBTEXT_COLOR
SearchBox.Text = ""
SearchBox.TextColor3 = TEXT_COLOR
SearchBox.TextSize = 12
SearchBox.Font = Enum.Font.SourceSans
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.Parent = SearchFrame

-- Danh sách Tab bên trái
local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Size = UDim2.new(1, -4, 1, -40)
TabScroll.Position = UDim2.new(0, 2, 0, 36)
TabScroll.BackgroundTransparency = 1
TabScroll.BorderSizePixel = 0
TabScroll.ScrollBarThickness = 2
TabScroll.ScrollBarImageColor3 = ACCENT_COLOR
TabScroll.Parent = Sidebar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 3)
TabListLayout.Parent = TabScroll

-- Bảng nội dung bên phải (Content Panel)
local ContentPanel = Instance.new("Frame")
ContentPanel.Size = UDim2.new(1, -214, 1, -40)
ContentPanel.Position = UDim2.new(0, 206, 0, 32)
ContentPanel.BackgroundColor3 = PANEL_COLOR
ContentPanel.BorderSizePixel = 0
ContentPanel.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 5)
ContentCorner.Parent = ContentPanel

-- Tiêu đề Tab đang chọn
local HeaderText = Instance.new("TextLabel")
HeaderText.Size = UDim2.new(1, -20, 0, 28)
HeaderText.Position = UDim2.new(0, 10, 0, 4)
HeaderText.BackgroundTransparency = 1
HeaderText.Text = "Shop"
HeaderText.TextColor3 = TEXT_COLOR
HeaderText.TextSize = 15
HeaderText.Font = Enum.Font.SourceSansBold
HeaderText.TextXAlignment = Enum.TextXAlignment.Left
HeaderText.Parent = ContentPanel

-- Đường gạch ngang phân cách
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, -20, 0, 1)
Divider.Position = UDim2.new(0, 10, 0, 34)
Divider.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
Divider.BorderSizePixel = 0
Divider.Parent = ContentPanel

-- Hệ thống Tab & Toggles
local Tabs = {}

local function CreateTab(name, isDefault)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, -4, 0, 26)
    TabButton.BackgroundTransparency = 1
    TabButton.Text = ""
    TabButton.Parent = TabScroll

    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 3, 0, 16)
    Indicator.Position = UDim2.new(0, 3, 0.5, -8)
    Indicator.BackgroundColor3 = ACCENT_COLOR
    Indicator.BorderSizePixel = 0
    Indicator.Visible = false
    Indicator.Parent = TabButton
    
    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(0, 2)
    IndicatorCorner.Parent = Indicator

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -15, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = SUBTEXT_COLOR
    Label.TextSize = 13
    Label.Font = Enum.Font.SourceSansBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = TabButton

    local ItemScroll = Instance.new("ScrollingFrame")
    ItemScroll.Size = UDim2.new(1, -12, 1, -42)
    ItemScroll.Position = UDim2.new(0, 6, 0, 38)
    ItemScroll.BackgroundTransparency = 1
    ItemScroll.BorderSizePixel = 0
    ItemScroll.ScrollBarThickness = 3
    ItemScroll.ScrollBarImageColor3 = ACCENT_COLOR
    ItemScroll.Visible = false
    ItemScroll.Parent = ContentPanel

    local ItemLayout = Instance.new("UIListLayout")
    ItemLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ItemLayout.Padding = UDim.new(0, 4)
    ItemLayout.Parent = ItemScroll

    local function Select()
        for _, tab in pairs(Tabs) do
            tab.Indicator.Visible = false
            tab.Label.TextColor3 = SUBTEXT_COLOR
            tab.ItemScroll.Visible = false
        end
        Indicator.Visible = true
        Label.TextColor3 = TEXT_COLOR
        HeaderText.Text = name
        ItemScroll.Visible = true
    end

    TabButton.MouseButton1Click:Connect(Select)

    local tabData = {
        Indicator = Indicator,
        Label = Label,
        ItemScroll = ItemScroll,
        ItemLayout = ItemLayout
    }
    table.insert(Tabs, tabData)

    if isDefault then Select() end
    TabScroll.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y)
    return tabData
end

local function AddToggle(tabData, text, defaultState, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -4, 0, 30)
    ToggleFrame.BackgroundColor3 = ITEM_COLOR
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = tabData.ItemScroll

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 4)
    ToggleCorner.Parent = ToggleFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = text
    Title.TextColor3 = TEXT_COLOR
    Title.TextSize = 13
    Title.Font = Enum.Font.SourceSansBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = ToggleFrame

    -- Ô vuông Checkbox viền vàng chuẩn mẫu
    local CheckBox = Instance.new("Frame")
    CheckBox.Size = UDim2.new(0, 16, 0, 16)
    CheckBox.Position = UDim2.new(1, -24, 0.5, -8)
    CheckBox.BackgroundColor3 = defaultState and ACCENT_COLOR or BG_COLOR
    CheckBox.BorderSizePixel = 0
    CheckBox.Parent = ToggleFrame

    local CheckCorner = Instance.new("UICorner")
    CheckCorner.CornerRadius = UDim.new(0, 3)
    CheckCorner.Parent = CheckBox

    local CheckStroke = Instance.new("UIStroke")
    CheckStroke.Color = ACCENT_COLOR
    CheckStroke.Thickness = 1.5
    CheckStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    CheckStroke.Parent = CheckBox

    local state = defaultState or false

    local ClickBtn = Instance.new("TextButton")
    ClickBtn.Size = UDim2.new(1, 0, 1, 0)
    ClickBtn.BackgroundTransparency = 1
    ClickBtn.Text = ""
    ClickBtn.Parent = ToggleFrame

    ClickBtn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(CheckBox, TweenInfo.new(0.12), {
            BackgroundColor3 = state and ACCENT_COLOR or BG_COLOR
        }):Play()
        if callback then pcall(callback, state) end
    end)

    tabData.ItemScroll.CanvasSize = UDim2.new(0, 0, 0, tabData.ItemLayout.AbsoluteContentSize.Y)
end

-- TẠO CÁC TAB THEO ĐÚNG ẢNH
local ShopTab = CreateTab("Shop", true)
local StatusTab = CreateTab("Status And Server", false)
local LocalTab = CreateTab("LocalPlayer", false)
local SettingTab = CreateTab("Setting Farm", false)
local SkillTab = CreateTab("Hold and Select Skill", false)
local FarmTab = CreateTab("Farming", false)
local StackTab = CreateTab("Stack Farming", false)
local OtherTab = CreateTab("Farming Other", false)
local RaidTab = CreateTab("Fruit and Raid", false)
local SeaTab = CreateTab("Sea Event", false)

-- THÊM CÁC MỤC VÀO TAB SHOP (Giao diện giống ảnh)
local shopItems = {
    {Name = "Black Leg", State = false},
    {Name = "Fishman Karate", State = false},
    {Name = "Electro", State = true}, -- Đang bật giống ảnh
    {Name = "Dragon Breath", State = false},
    {Name = "SuperHuman", State = false},
    {Name = "Death Step", State = false},
    {Name = "Sharkman Karate", State = false},
    {Name = "Electric Claw", State = false}
}

for _, item in ipairs(shopItems) do
    AddToggle(ShopTab, item.Name, item.State, function(value)
        -- Thêm code chức năng mua võ ở đây
        print(item.Name .. ": ", value)
    end)
end
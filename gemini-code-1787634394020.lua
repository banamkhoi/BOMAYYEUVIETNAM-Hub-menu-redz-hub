-- Banana Cat Hub - Blox Fruit (Delta Optimized & Accurate UI)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("BananaCatHubUI") then
    CoreGui.BananaCatHubUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BananaCatHubUI"
ScreenGui.Parent = (gethui and gethui()) or CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Bảng màu chuẩn từ ảnh thực tế
local BG_COLOR = Color3.fromRGB(13, 13, 15)
local PANEL_COLOR = Color3.fromRGB(19, 19, 22)
local ITEM_COLOR = Color3.fromRGB(26, 26, 30)
local ACCENT_COLOR = Color3.fromRGB(250, 185, 15) -- Màu vàng đặc trưng Banana Cat
local TEXT_COLOR = Color3.fromRGB(240, 240, 245)
local SUBTEXT_COLOR = Color3.fromRGB(140, 140, 148)

-- Khung chính
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 580, 0, 340)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -170)
MainFrame.BackgroundColor3 = BG_COLOR
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = MainFrame

-- Kéo thả Menu (Hỗ trợ cực mượt trên Delta Mobile & PC)
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
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

-- Thanh tiêu đề phía trên
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

-- Sidebar bên trái
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 190, 1, -40)
Sidebar.Position = UDim2.new(0, 8, 0, 32)
Sidebar.BackgroundColor3 = PANEL_COLOR
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 5)
SidebarCorner.Parent = Sidebar

-- Ô tìm kiếm Tab
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

-- Khu vực nội dung bên phải
local ContentPanel = Instance.new("Frame")
ContentPanel.Size = UDim2.new(1, -214, 1, -40)
ContentPanel.Position = UDim2.new(0, 206, 0, 32)
ContentPanel.BackgroundColor3 = PANEL_COLOR
ContentPanel.BorderSizePixel = 0
ContentPanel.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 5)
ContentCorner.Parent = ContentPanel

local Tabs = {}

local function CreateTab(name, isDefault)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, -4, 0, 26)
    TabButton.BackgroundTransparency = 1
    TabButton.Text = ""
    TabButton.Parent = TabScroll

    -- Thanh chỉ báo màu vàng dọc bên trái tên Tab chuẩn ảnh
    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 3, 0, 14)
    Indicator.Position = UDim2.new(0, 2, 0.5, -7)
    Indicator.BackgroundColor3 = ACCENT_COLOR
    Indicator.BorderSizePixel = 0
    Indicator.Visible = false
    Indicator.Parent = TabButton
    
    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(0, 2)
    IndicatorCorner.Parent = Indicator

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -12, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = SUBTEXT_COLOR
    Label.TextSize = 13
    Label.Font = Enum.Font.SourceSansBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = TabButton

    local ItemScroll = Instance.new("ScrollingFrame")
    ItemScroll.Size = UDim2.new(1, -12, 1, -12)
    ItemScroll.Position = UDim2.new(0, 6, 0, 6)
    ItemScroll.BackgroundTransparency = 1
    ItemScroll.BorderSizePixel = 0
    ItemScroll.ScrollBarThickness = 3
    ItemScroll.ScrollBarImageColor3 = ACCENT_COLOR
    ItemScroll.Visible = false
    ItemScroll.Parent = ContentPanel

    local ItemLayout = Instance.new("UIListLayout")
    ItemLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ItemLayout.Padding = UDim.new(0, 5)
    ItemLayout.Parent = ItemScroll

    local function Select()
        for _, tab in pairs(Tabs) do
            tab.Indicator.Visible = false
            tab.Label.TextColor3 = SUBTEXT_COLOR
            tab.ItemScroll.Visible = false
        end
        Indicator.Visible = true
        Label.TextColor3 = TEXT_COLOR
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

-- Thêm tiêu đề danh mục phụ (Ví dụ: Misc Shop)
local function AddSectionTitle(tabData, text)
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 24)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = text
    TitleLabel.TextColor3 = ACCENT_COLOR
    TitleLabel.TextSize = 13
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Parent = tabData.ItemScroll
    tabData.ItemScroll.CanvasSize = UDim2.new(0, 0, 0, tabData.ItemLayout.AbsoluteContentSize.Y)
end

-- Thêm nút bấm "Click" dạng viên thuốc giống ảnh thứ 2
local function AddButton(tabData, text, callback)
    local BtnFrame = Instance.new("Frame")
    BtnFrame.Size = UDim2.new(1, -4, 0, 36)
    BtnFrame.BackgroundColor3 = ITEM_COLOR
    BtnFrame.BorderSizePixel = 0
    BtnFrame.Parent = tabData.ItemScroll

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = BtnFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -90, 1, 0)
    Title.Position = UDim2.new(0, 12, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = text
    Title.TextColor3 = TEXT_COLOR
    Title.TextSize = 13
    Title.Font = Enum.Font.SourceSansBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = BtnFrame

    local ActionBtn = Instance.new("TextButton")
    ActionBtn.Size = UDim2.new(0, 75, 0, 24)
    ActionBtn.Position = UDim2.new(1, -85, 0.5, -12)
    ActionBtn.BackgroundColor3 = ACCENT_COLOR
    ActionBtn.Text = "Click"
    ActionBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
    ActionBtn.TextSize = 12
    ActionBtn.Font = Enum.Font.SourceSansBold
    ActionBtn.Parent = BtnFrame

    local BtnCornerInner = Instance.new("UICorner")
    BtnCornerInner.CornerRadius = UDim.new(0, 4)
    BtnCornerInner.Parent = ActionBtn

    ActionBtn.MouseButton1Click:Connect(function()
        if callback then pcall(callback) end
    end)

    tabData.ItemScroll.CanvasSize = UDim2.new(0, 0, 0, tabData.ItemLayout.AbsoluteContentSize.Y)
end

-- TẠO CÁC TAB CHUẨN XÁC
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

-- XÂY DỰNG NỘI DUNG TAB SHOP GIỐNG ẢNH 2
AddSectionTitle(ShopTab, "Misc Shop")
AddButton(ShopTab, "Redeem Code", function() print("Redeem Code Clicked") end)
AddButton(ShopTab, "Teleport Old World", function() print("Teleport Old World Clicked") end)
AddButton(ShopTab, "Teleport New World", function() print("Teleport New World Clicked") end)
AddButton(ShopTab, "Teleport Thid Sea", function() print("Teleport Thid Sea Clicked") end)
AddButton(ShopTab, "Buy Dual Flintlock", function() print("Buy Dual Flintlock Clicked") end)
AddButton(ShopTab, "Reroll Race", function() print("Reroll Race Clicked") end)
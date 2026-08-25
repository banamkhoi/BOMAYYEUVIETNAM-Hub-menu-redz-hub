-- Banana Cat Hub - Blox Fruit (Full Toggle & Notification System)
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

-- Bảng màu chuẩn
local BG_COLOR = Color3.fromRGB(13, 13, 15)
local PANEL_COLOR = Color3.fromRGB(19, 19, 22)
local ITEM_COLOR = Color3.fromRGB(26, 26, 30)
local ACCENT_COLOR = Color3.fromRGB(250, 185, 15) -- Màu vàng Banana Cat
local TEXT_COLOR = Color3.fromRGB(240, 240, 245)
local SUBTEXT_COLOR = Color3.fromRGB(140, 140, 148)

----------------------------------------------------------------
-- 1. KÍCH HOẠT NÚT BẤM BẬT/TẮT MENU (TOGGLE BUTTON - GÓC DƯỚI BÊN TRÁI)
----------------------------------------------------------------
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "ToggleButton"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 15, 1, -75) -- Đặt ở góc dưới bên trái
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Image = "rbxassetid://10723380448" -- Icon Banana Cat
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0) -- Bo tròn thành hình cầu
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = ACCENT_COLOR
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

-- Cho phép kéo thả nút Toggle trên màn hình mobile/PC
local btnDragging, btnDragStart, btnStartPos
ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = true
        btnDragStart = input.Position
        btnStartPos = ToggleBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then btnDragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if btnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - btnDragStart
        ToggleBtn.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
    end
end)

----------------------------------------------------------------
-- 2. KHUNG MENU CHÍNH (MAIN FRAME)
----------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 580, 0, 340)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -170)
MainFrame.BackgroundColor3 = BG_COLOR
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false -- Tự động ẩn UI khi vừa chạy theo đúng thông báo
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = MainFrame

-- Sự kiện nhấn nút để Bật / Tắt Menu
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Kéo thả Menu
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
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Title Bar
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

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 190, 1, -40)
Sidebar.Position = UDim2.new(0, 8, 0, 32)
Sidebar.BackgroundColor3 = PANEL_COLOR
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 5)
SidebarCorner.Parent = Sidebar

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

-- Content Panel
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

-- TẠO TAB & NỘI DUNG
local ShopTab = CreateTab("Shop", true)
CreateTab("Status And Server", false)
CreateTab("LocalPlayer", false)
CreateTab("Setting Farm", false)
CreateTab("Hold and Select Skill", false)
CreateTab("Farming", false)
CreateTab("Stack Farming", false)
CreateTab("Farming Other", false)
CreateTab("Fruit and Raid", false)
CreateTab("Sea Event", false)

AddSectionTitle(ShopTab, "Misc Shop")
AddButton(ShopTab, "Redeem Code", function() print("Redeem Code Clicked") end)
AddButton(ShopTab, "Teleport Old World", function() print("Teleport Old World Clicked") end)
AddButton(ShopTab, "Teleport New World", function() print("Teleport New World Clicked") end)
AddButton(ShopTab, "Teleport Thid Sea", function() print("Teleport Thid Sea Clicked") end)

----------------------------------------------------------------
-- 3. BẢNG THÔNG BÁO (NOTIFICATION POPUP CHUẨN ẢNH THỨ 3)
----------------------------------------------------------------
local NotifFrame = Instance.new("Frame")
NotifFrame.Name = "Notification"
NotifFrame.Size = UDim2.new(0, 310, 0, 80)
NotifFrame.Position = UDim2.new(1, -325, 1, -95) -- Góc dưới bên phải
NotifFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
NotifFrame.BorderSizePixel = 0
NotifFrame.Parent = ScreenGui

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 6)
NotifCorner.Parent = NotifFrame

local NotifIcon = Instance.new("ImageLabel")
NotifIcon.Size = UDim2.new(0, 16, 0, 16)
NotifIcon.Position = UDim2.new(0, 10, 0, 8)
NotifIcon.BackgroundTransparency = 1
NotifIcon.Image = "rbxassetid://10723380448"
NotifIcon.Parent = NotifFrame

local NotifTitle = Instance.new("TextLabel")
NotifTitle.Size = UDim2.new(1, -60, 0, 16)
NotifTitle.Position = UDim2.new(0, 32, 0, 8)
NotifTitle.BackgroundTransparency = 1
NotifTitle.Text = "Banana Cat Hub UI Library"
NotifTitle.TextColor3 = ACCENT_COLOR
NotifTitle.TextSize = 13
NotifTitle.Font = Enum.Font.SourceSansBold
NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
NotifTitle.Parent = NotifFrame

local CloseNotif = Instance.new("TextButton")
CloseNotif.Size = UDim2.new(0, 20, 0, 20)
CloseNotif.Position = UDim2.new(1, -24, 0, 6)
CloseNotif.BackgroundTransparency = 1
CloseNotif.Text = "✕"
CloseNotif.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseNotif.TextSize = 12
CloseNotif.Font = Enum.Font.SourceSansBold
CloseNotif.Parent = NotifFrame

CloseNotif.MouseButton1Click:Connect(function()
    NotifFrame:Destroy()
end)

local NotifText = Instance.new("TextLabel")
NotifText.Size = UDim2.new(1, -20, 0, 45)
NotifText.Position = UDim2.new(0, 10, 0, 28)
NotifText.BackgroundTransparency = 1
NotifText.Text = "The UI automatically hides once executed.\nPress the button at the bottom-left of the screen to show the GUI."
NotifText.TextColor3 = Color3.fromRGB(220, 220, 220)
NotifText.TextSize = 11
NotifText.Font = Enum.Font.SourceSans
NotifText.TextWrapped = true
NotifText.TextXAlignment = Enum.TextXAlignment.Left
NotifText.TextYAlignment = Enum.TextYAlignment.Top
NotifText.Parent = NotifFrame
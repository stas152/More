local env = getfenv()
local h = env.hookfunc or env.hookfunction or env.replaceclosure or (env.getgenv and env.getgenv().hookfunc) or (env.getgenv and env.getgenv().hookfunction)

local d = {
    ["バナナを食べてからバナナを捨ててオンにして、バナナを、掴む"] = "Eat banana, drop banana, turn ON, then grab banana",
    ["ウエブフック逆探知。ウエブフックのリンクコピーをコピーする"] = "Webhook traceback. Copies webhook link",
    ["アンチウエブフック追加。いやんはぶ起動時に自動で起動"] = "Anti-Webhook added. Auto-starts with Iyan Hub",
    ["選択したプレイヤーに当てる、ライン量"] = "Target Player Line Amount",
    ["クレイジーライン、ライン量"] = "Crazy Lines Amount",
    ["ラグサーバー、ライン量"] = "Lag Server Line Amount",
    ["テレポートスクリプトv1 (cheeky)"] = "Teleport Script V1 (cheeky)",
    ["テレポートスクリプトv2 (はろ)"] = "Teleport Script V2 (haro)",
    ["ランダム高速テレポート切替"] = "Toggle Random Fast Teleport",
    ["どこでも突破するプレイヤーを選ぶ"] = "Choose player to bypass anywhere",
    ["ホワリスに入れたいプレイヤーを選ぶ"] = "Select Player to Whitelist",
    ["視点を見たいプレイヤーを選択"] = "Select player to spectate",
    ["リスキルしたいプレイヤーを選ぶ"] = "Select player to spawnkill",
    ["100均のFovチェンジャー😃"] = "Cheap FOV Changer 😃",
    ["ウエブフックの情報送信を防ぐ"] = "Prevents webhook information from being sent",
    ["これはまだテストです。追加済み"] = "This is still a test. Added.",
    ["当てたいプレイヤーを選ぶ"] = "Choose Target Player",
    ["選択したプレイヤーに当てる"] = "Target Selected Player",
    ["プレイヤーのリストを更新"] = "Refresh Player List",
    ["ホワリスに入ってるプレイヤー"] = "Whitelisted Players",
    ["Bringしたいプレイヤーを選択"] = "Select Player to Bring",
    ["食べたらオンにしてゲロかけてください"] = "Turn ON after eating and vomit on them",
    ["直接突破無効,雪玉"] = "Direct Bypass Disable, Snowball",
    ["高さを保ちながら掴む"] = "Stable Height Grab",
    ["ウエブフックコピー"] = "Webhook Copy",
    ["オブジェクトオーラ"] = "Object Aura",
    ["オブジェクト削除オーラ"] = "Object Delete Aura",
    ["オブジェクト掴むオーラ"] = "Object Grab Aura",
    ["いやんはぶのグループ"] = "Iyan Hub Group",
    ["いやんはぶグループ"] = "Iyan Hub Group",
    ["アンチウエブフック内容"] = "Anti-Webhook Content",
    ["プレイヤーにテレポート"] = "Teleport to Player",
    ["弱いラグサーバー"] = "Weak Lag Server",
    ["ライン曲がりなし"] = "Straight Lines",
    ["Radioactive 掴む"] = "Radioactive Grab",
    ["デメリット高い荒らす用"] = "High Disadvantage Grief",
    ["アンチラグドールテスト"] = "Anti Ragdoll Test",
    ["アン치掴む　V２"] = "Anti Grab V2",
    ["アンチ掴む　V２"] = "Anti Grab V2",
    ["アンチキック解除"] = "Anti Kick Release",
    ["アンチブロブマンv2"] = "Anti Blobman V2",
    ["アンチブリングtest"] = "Anti Bring Test",
    ["ラグドール起こし"] = "Wake from Ragdoll",
    ["アンチファイヤall"] = "Anti Fire All",
    ["アンチフリング：ON"] = "Anti Fling: ON",
    ["連続テレポート停止"] = "Stop Continuous Teleport",
    ["オートテレポート家"] = "Auto Teleport Home",
    ["スロットの裏の洞窟"] = "Cave Behind Slots",
    ["アカウントの時間"] = "Account Age",
    ["うんこは自分でお願いします…"] = "Please poop by yourself...",
    ["選択したプレイヤーをbling"] = "Bring Selected Player",
    ["高速allの速度"] = "High Speed All Speed",
    ["radioactiveオーラ"] = "Radioactive Aura",
    ["FPS上限解放"] = "Unlock FPS Limit",
    ["キャラクターの移動"] = "Character Movement",
    ["キャラクターのスピード"] = "Character Speed",
    ["キャラクターの高さ"] = "Character Height",
    ["ジャンプの高さ"] = "Jump Height",
    ["ブロブマン無効"] = "Disable Blobman",
    ["山の緑の家"] = "Mountain Green House",
    ["赤い畑の家"] = "Red Field House",
    ["プレイヤーの視点をみる"] = "Spectate Player",
    ["アンチブロブマン"] = "Anti Blobman",
    ["アンチリスキル"] = "Anti Spawnkill",
    ["アンチ雪玉V2"] = "Anti Snowball V2",
    ["Bring軽減座標"] = "Bring Dampening Coordinates",
    ["掴んだやつを飛ばす"] = "Fling Grabbed Player",
    ["オールのモード"] = "All Mode",
    ["ホワリスに追加"] = "Add to Whitelist",
    ["ホワイトフレンド"] = "Whitelisted Friends",
    ["38桁座標いもり"] = "38-Digit Camp",
    ["準突破無効"] = "Semi-Bypass Disable",
    ["上に上がるオーラ"] = "Rising Aura",
    ["相手が埋まる"] = "Bury Enemy",
    ["無限ジャンプ"] = "Infinite Jump",
    ["重力スライド式"] = "Gravity Slider",
    ["オレンジ？の家"] = "Orange? House",
    ["普通の洞窟"] = "Normal Cave",
    ["表示の名前"] = "Display Name",
    ["ゲームの名前"] = "Game Name",
    ["どこでも突破"] = "Bypass Anywhere",
    ["アップデートログ"] = "Update Log",
    ["サーバークラッシュ"] = "Server Crash",
    ["クレイジーライン"] = "Crazy Lines",
    ["ノクリップ掴む"] = "Noclip Grab",
    ["ゲロかけALL"] = "Vomit on All",
    ["アンチファイヤ"] = "Anti Fire",
    ["アンチ雪玉"] = "Anti Snowball",
    ["キックオール"] = "Kick All",
    ["自動お座り"] = "Auto Sit",
    ["フリングオーラ"] = "Fling Aura",
    ["フリーズオーラ"] = "Freeze Aura",
    ["スピンオーラ"] = "Spin Aura",
    ["視野角を戻す"] = "Reset FOV",
    ["上に上がる掴む"] = "Rising Grab",
    ["下に下がる掴む"] = "Falling Grab",
    ["オブジェクト系"] = "Objects",
    ["ブロブマン掴む"] = "Grab Blobman",
    ["カラーライン"] = "Color Lines",
    ["透明ライン"] = "Transparent Lines",
    ["プレイヤーを選択"] = "Select Player",
    ["ラグサバ V3"] = "Lag Server V3",
    ["投げる強さ"] = "Throw Strength",
    ["全員燃やす"] = "Burn All",
    ["UFO落とし"] = "Drop UFOs",
    ["列車落とし"] = "Drop Train",
    ["アンチ掴む"] = "Anti Grab",
    ["アンチ爆発"] = "Anti Explosion",
    ["Bring軽減"] = "Bring Dampening",
    ["高速all"] = "High Speed All",
    ["ホワリス削除"] = "Remove from Whitelist",
    ["掴むオーラ"] = "Grab Aura",
    ["無敵OFF"] = "Invincibility OFF",
    ["無敵 ON"] = "Invincibility ON",
    ["無敵 OFF"] = "Invincibility OFF",
    ["座標分かる"] = "Show Coordinates",
    ["キル掴む"] = "Kill Grab",
    ["紫の家"] = "Purple House",
    ["緑の家"] = "Green House",
    ["青の家"] = "Blue House",
    ["赤の家"] = "Red House",
    ["毒井戸"] = "Poison Well",
    ["ユーザーname"] = "Username",
    ["リスト更新"] = "Refresh List",
    ["見る部位"] = "Target Part",
    ["アンカー掴む"] = "Anchor Grab",
    ["アンカー解除"] = "Release Anchor",
    ["キルオール"] = "Kill All",
    ["回転方向"] = "Rotation Direction",
    ["リングの範囲"] = "Ring Range",
    ["リングの高さ"] = "Ring Height",
    ["回転スピード"] = "Rotation Speed",
    ["にがーおーる"] = "Dark Oven All",
    ["ロード中"] = "Loading...",
    ["無敵突破"] = "Bypass Invincibility",
    ["リスキル系"] = "Spawnkill",
    ["ラグサーバー"] = "Lag Server",
    ["キャラクター"] = "Character",
    ["フリングスクリプト"] = "Fling Scripts",
    ["オールの速度"] = "All Speed",
    ["毒オーラ"] = "Poison Aura",
    ["三人称"] = "Third Person",
    ["座標v2"] = "Coordinates V2",
    ["緑おーる"] = "Green Microwave All",
    ["ブロブマン"] = "Blobman",
    ["いやん"] = "Iyan",
    ["掴む"] = "Grab",
    ["アンチ"] = "Anti",
    ["オーラ"] = "Aura",
    ["荒らす用"] = "Griefing",
    ["テレポート"] = "Teleport",
    ["スクリプト"] = "Scripts",
    ["ためし"] = "Test",
    ["情報"] = "Information",
    ["リンク"] = "Links",
    ["投げる"] = "Throw",
    ["毒掴む"] = "Poison Grab",
    ["燃やす掴む"] = "Fire Grab",
    ["ラグドールALL"] = "Ragdoll All",
    ["アンチラグ"] = "Anti Lag",
    ["アンチキック"] = "Anti Kick",
    ["座標"] = "Coordinates",
    ["半径"] = "Radius",
    ["ジャンプ"] = "Jump",
    ["無敵"] = "Invincibility",
    ["リス地"] = "Spawn Area",
    ["雪山"] = "Snow Mountain",
    ["リスキル"] = "Spawnkill",
    ["リング"] = "Ring",
    ["縦"] = "Vertical",
    ["横"] = "Horizontal",
    ["前"] = "Forward"
}

local k_sorted = {}
for k in pairs(d) do
    table.insert(k_sorted, k)
end
table.sort(k_sorted, function(a, b)
    return #a > #b
end)

local function r(s, f, t)
    local p = {}
    local st = 1
    while true do
        local o = s:find(f, st, true)
        if not o then break end
        table.insert(p, s:sub(st, o - 1))
        table.insert(p, t)
        st = o + #f
    end
    table.insert(p, s:sub(st))
    return table.concat(p)
end

local function tr(c)
    for _, k in ipairs(k_sorted) do
        c = r(c, k, d[k])
    end
    return c
end

if h then
    pcall(function()
        local o1
        o1 = h(game["HttpGet"], function(self, url, ...)
            local res = o1(self, url, ...)
            if typeof(url) == "string" and url:find("stas152/More/refs/heads/main/Script.lua", 1, true) then
                res = tr(res)
            end
            return res
        end)
    end)

    pcall(function()
        local o2
        o2 = h(game["HttpGetAsync"], function(self, url, ...)
            local res = o2(self, url, ...)
            if typeof(url) == "string" and url:find("stas152/More/refs/heads/main/Script.lua", 1, true) then
                res = tr(res)
            end
            return res
        end)
    end)
end

task.spawn(function()
    local s, res = pcall(function()
        return game["HttpGet"](game, "https://raw.githubusercontent.com/stas152/More/refs/heads/main/Script.lua")
    end)
    if s and typeof(res) == "string" then
        local f = loadstring(tr(res))
        if f then
            f()
        end
    end
end)

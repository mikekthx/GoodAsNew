local _, ns = ...

local L = setmetatable({}, {
	__index = function(t, k)
		local v = tostring(k)
		rawset(t, k, v)
		return v
	end
})
ns.L = L

-- Supported locales: enUS, enGB, deDE, frFR, esES, esMX, ruRU, koKR, zhCN, zhTW
local lang = GetLocale()

-- Do you speak English?
if lang == "enUS" or lang == "enGB" then
	L["Repair with guild money"] = "Repair with guild money"
	L["All the time"] = "All the time"
	L["Only in a raid group"] = "Only in a raid group"
	L["Hold Modifier Key to prevent repairing"] = "Hold Modifier Key to prevent repairing"
	L["Show messages in chat"] = "Show messages in chat"
	L["Currency display style:"] = "Currency display style:"
	L["Error formatting money!"] = "Error formatting money!"
	L["Display Warning"] = "Display Warning"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] = "Coin display may have visual artifacts.\nConsider using text options for cleaner display."
	L["Coin icons"] = "Coin icons"
	L["Short text"] = "Short text"
	L["Full text"] = "Full text"
	L["Use color formatting"] = "Use color formatting"
	L["g"] = {"g", " Gold"}
	L["s"] = {"s", " Silver"}
	L["c"] = {"c", " Copper"}
	L["Junk items sold for"] = "Junk items sold for"
	L["Repaired for"] = "Repaired for"
	L["Repaired from the guild bank for"] = "Repaired from the guild bank for"
	L["Not enough money to automatically repair!"] = "Not enough money to automatically repair!"
	return
end

-- Sprichst du Deutsch?
if lang == "deDE" then
	L["Repair with guild money"] = "Mit Gildenkasse reparieren"
	L["All the time"] = "Immer"
	L["Only in a raid group"] = "Nur in einer Schlachtzugsgruppe"
	L["Hold Modifier Key to prevent repairing"] = "Reparatur mit gedrückter Mod-Taste verhindern"
	L["Show messages in chat"] = "Nachrichten im Chat anzeigen"
	L["Currency display style:"] = "Anzeigeformat der Währung:"
	L["Error formatting money!"] = "Fehler beim Formatieren des Geldbetrags!"
	L["Display Warning"] = "Anzeige-Warnung"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] = "Die Anzeige von Münzsymbolen kann visuelle Artefakte enthalten.\nVerwenden Sie Textoptionen für eine saubere Darstellung."
	L["Coin icons"] = "Münzsymbole"
	L["Short text"] = "Kurztext"
	L["Full text"] = "Volltext"
	L["Use color formatting"] = "Farbliche Darstellung verwenden"
	L["g"] = {"g", " Gold"}
	L["s"] = {"s", " Silber"}
	L["c"] = {"k", " Kupfer"}
	L["Junk items sold for"] = "Graue Gegenstände verkauft für"
	L["Repaired for"] = "Repariert für"
	L["Repaired from the guild bank for"] = "Mit Gildenkasse repariert für"
	L["Not enough money to automatically repair!"] = "Nicht genug Geld zum automatischen Reparieren!"
	return
end

-- Parlez-vous français ?
if lang == "frFR" then
	L["Repair with guild money"] = "Réparer avec l'argent de la guilde"
	L["All the time"] = "Tout le temps"
	L["Only in a raid group"] = "Uniquement en groupe de raid"
	L["Hold Modifier Key to prevent repairing"] = "Maintenir une touche modificatrice pour bloquer la réparation"
	L["Show messages in chat"] = "Afficher les messages dans le chat"
	L["Currency display style:"] = "Style d’affichage de la monnaie :"
	L["Error formatting money!"] = "Erreur lors du formatage de l’argent !"
	L["Display Warning"] = "Avertissement d’affichage"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] = "L’affichage des pièces peut provoquer des artefacts visuels.\nUtilisez une option textuelle pour un affichage plus propre."
	L["Coin icons"] = "Icônes de pièces"
	L["Short text"] = "Texte court"
	L["Full text"] = "Texte complet"
	L["Use color formatting"] = "Utiliser la mise en couleur"
	L["g"] = {"po", " Pièces d’or"}
	L["s"] = {"pa", " Pièces d’argent"}
	L["c"] = {"pc", " Pièces de cuivre"}
	L["Junk items sold for"] = "Objets gris vendus pour"
	L["Repaired for"] = "Réparé pour"
	L["Repaired from the guild bank for"] = "Réparé avec les fonds de la guilde pour"
	L["Not enough money to automatically repair!"] = "Pas assez d'argent pour réparer automatiquement !"
	return
end

-- ¿Hablas español?
if lang == "esES" or lang == "esMX" then
	L["Repair with guild money"] = "Reparar con fondos de la hermandad"
	L["All the time"] = "Siempre"
	L["Only in a raid group"] = "Solo en una banda"
	L["Hold Modifier Key to prevent repairing"] = "Mantén una tecla modificadora para evitar la reparación"
	L["Show messages in chat"] = "Mostrar mensajes en el chat"
	L["Currency display style:"] = "Estilo de visualización de la moneda:"
	L["Error formatting money!"] = "¡Error al formatear el dinero!"
	L["Display Warning"] = "Advertencia de visualización"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] = "La visualización de monedas puede tener artefactos visuales.\nConsidera usar las opciones de texto para una vista más limpia."
	L["Coin icons"] = "Iconos de monedas"
	L["Short text"] = "Texto corto"
	L["Full text"] = "Texto completo"
	L["Use color formatting"] = "Usar formato en color"
	L["g"] = {"o", " Oro"}
	L["s"] = {"p", " Plata"}
	L["c"] = {"c", " Cobre"}
	L["Junk items sold for"] = "Objetos grises vendidos por"
	L["Repaired for"] = "Reparado por"
	L["Repaired from the guild bank for"] = "Reparado con fondos de la hermandad por"
	L["Not enough money to automatically repair!"] = "¡No hay suficiente dinero para reparar automáticamente!"
	return
end

-- Вы говорите по-русски?
if lang == "ruRU" then
	L["Repair with guild money"] = "Ремонт за счет гильдии"
	L["All the time"] = "Всегда"
	L["Only in a raid group"] = "Только в рейде"
	L["Hold Modifier Key to prevent repairing"] = "Зажмите клавишу-модификатор, чтобы не чинить"
	L["Show messages in chat"] = "Показывать сообщения в чате"
	L["Currency display style:"] = "Стиль отображения валюты:"
	L["Error formatting money!"] = "Ошибка форматирования суммы!"
	L["Display Warning"] = "Предупреждение отображения"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] = "Отображение монет может содержать визуальные артефакты.\nРекомендуется использовать текстовый режим для чистоты отображения."
	L["Coin icons"] = "Значки монет"
	L["Short text"] = "Краткий текст"
	L["Full text"] = "Полный текст"
	L["Use color formatting"] = "Использовать цветное оформление"
	L["g"] = {"з", " Золотых"}
	L["s"] = {"с", " Серебряных"}
	L["c"] = {"м", " Медных"}
	L["Junk items sold for"] = "Продажа серых предметов:"
	L["Repaired for"] = "Отремонтировано за"
	L["Repaired from the guild bank for"] = "Отремонтировано за счет гильдии"
	L["Not enough money to automatically repair!"] = "Недостаточно денег для автоматического ремонта!"
	return
end

-- 한국어 할 줄 아세요?
if lang == "koKR" then
	L["Repair with guild money"] = "길드 자금으로 수리"
	L["All the time"] = "항상"
	L["Only in a raid group"] = "공격대일 때만"
	L["Hold Modifier Key to prevent repairing"] = "보조 키를 눌러 수리 방지"
	L["Show messages in chat"] = "채팅에 메시지 표시"
	L["Currency display style:"] = "통화 표시 형식:"
	L["Error formatting money!"] = "금액 형식 지정 오류!"
	L["Display Warning"] = "표시 경고"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] = "동전 아이콘 표시 시 시각적 결함이 있을 수 있습니다.\n더 깔끔한 표시를 위해 텍스트 옵션을 고려하세요."
	L["Coin icons"] = "아이콘"
	L["Short text"] = "짧은 텍스트"
	L["Full text"] = "전체 텍스트"
	L["Use color formatting"] = "색상 형식 사용"
	L["g"] = {"금", " 금화"}
	L["s"] = {"은", " 은화"}
	L["c"] = {"동", " 동화"}
	L["Junk items sold for"] = "잡템 판매 금액:"
	L["Repaired for"] = "수리 비용:"
	L["Repaired from the guild bank for"] = "길드 자금으로 수리:"
	L["Not enough money to automatically repair!"] = "자동 수리에 충분한 돈이 없습니다!"
	return
end

-- 你会说中文吗？
if lang == "zhCN" then
	L["Repair with guild money"] = "使用公会资金修理"
	L["All the time"] = "总是"
	L["Only in a raid group"] = "仅在团队中"
	L["Hold Modifier Key to prevent repairing"] = "按住修饰键可防修理"
	L["Show messages in chat"] = "在聊天中显示信息"
	L["Currency display style:"] = "货币显示样式："
	L["Error formatting money!"] = "货币格式化错误！"
	L["Display Warning"] = "显示警告"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] = "货币图标显示可能存在视觉问题。\n建议使用文本样式以获得更清晰的显示效果。"
	L["Coin icons"] = "图标"
	L["Short text"] = "简短文本"
	L["Full text"] = "完整文本"
	L["Use color formatting"] = "使用颜色格式"
	L["g"] = {"金", " 金币"}
	L["s"] = {"银", " 银币"}
	L["c"] = {"铜", " 铜币"}
	L["Junk items sold for"] = "出售灰色物品所得："
	L["Repaired for"] = "修理费用："
	L["Repaired from the guild bank for"] = "使用公会资金修理："
	L["Not enough money to automatically repair!"] = "没有足够的钱自动修理！"
	return
end

-- 你會說中文嗎？
if lang == "zhTW" then
	L["Repair with guild money"] = "使用公會資金修理"
	L["All the time"] = "總是"
	L["Only in a raid group"] = "僅限團隊中"
	L["Hold Modifier Key to prevent repairing"] = "按住組合鍵可防修理"
	L["Show messages in chat"] = "在聊天中顯示訊息"
	L["Currency display style:"] = "貨幣顯示樣式："
	L["Error formatting money!"] = "金額格式化錯誤！"
	L["Display Warning"] = "顯示警告"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] = "硬幣圖示顯示可能會產生視覺異常。\n建議使用文字選項以獲得更清晰的顯示效果。"
	L["Coin icons"] = "圖示"
	L["Short text"] = "簡短文字"
	L["Full text"] = "完整文字"
	L["Use color formatting"] = "使用顏色格式"
	L["g"] = {"金", " 金幣"}
	L["s"] = {"銀", " 銀幣"}
	L["c"] = {"銅", " 銅幣"}
	L["Junk items sold for"] = "賣出灰色物品獲得："
	L["Repaired for"] = "修理費用："
	L["Repaired from the guild bank for"] = "使用公會資金修理："
	L["Not enough money to automatically repair!"] = "沒有足夠的金錢進行自動修理！"
	return
end

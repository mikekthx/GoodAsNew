local _, ns = ...

local L = setmetatable({}, {
	__index = function(t, k)
		local v = tostring(k)
		rawset(t, k, v)
		return v
	end
})
ns.L = L

-- Supported locales: enUS, enGB, deDE, frFR, esES, esMX, ruRU, ptBR, itIT, koKR, zhCN, zhTW
local lang = GetLocale()

-- Do you speak English?
if lang == "enUS" or lang == "enGB" then
	L["Repair with guild bank funds"] = "Repair with guild bank funds"
	L["Off"] = "Off"
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
	L["Repair with guild bank funds"] = "Mit der Gildenbank reparieren"
	L["Off"] = "Aus"
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
	L["Junk items sold for"] = "Plunder verkauft für"
	L["Repaired for"] = "Repariert für"
	L["Repaired from the guild bank for"] = "Aus der Gildenbank repariert für"
	L["Not enough money to automatically repair!"] = "Nicht genug Geld zum automatischen Reparieren!"
	return
end

-- Parlez-vous français ?
if lang == "frFR" then
	L["Repair with guild bank funds"] = "Réparer avec la banque de guilde"
	L["Off"] = "Désactivé"
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
	L["g"] = {"po", " or"}
	L["s"] = {"pa", " argent"}
	L["c"] = {"pc", " cuivre"}
	L["Junk items sold for"] = "Camelote vendue pour"
	L["Repaired for"] = "Réparé pour"
	L["Repaired from the guild bank for"] = "Réparé avec la banque de guilde pour"
	L["Not enough money to automatically repair!"] = "Pas assez d'argent pour réparer automatiquement !"
	return
end

-- ¿Hablas español?
if lang == "esES" or lang == "esMX" then
	L["Repair with guild bank funds"] = "Reparar con el banco de hermandad"
	L["Off"] = "Desactivado"
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
	L["g"] = {"o", " oro"}
	L["s"] = {"p", " plata"}
	L["c"] = {"c", " cobre"}
	L["Junk items sold for"] = "Chatarra vendida por"
	L["Repaired for"] = "Reparado por"
	L["Repaired from the guild bank for"] = "Reparado con el banco de hermandad por"
	L["Not enough money to automatically repair!"] = "¡No hay suficiente dinero para reparar automáticamente!"
	return
end

-- Вы говорите по-русски?
if lang == "ruRU" then
	L["Repair with guild bank funds"] = "Ремонт за счет банка гильдии"
	L["Off"] = "Выключено"
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
	L["g"] = {"з", " золото"}
	L["s"] = {"с", " серебро"}
	L["c"] = {"м", " медь"}
	L["Junk items sold for"] = "Хлам продан за"
	L["Repaired for"] = "Отремонтировано за"
	L["Repaired from the guild bank for"] = "Отремонтировано из банка гильдии за"
	L["Not enough money to automatically repair!"] = "Недостаточно денег для автоматического ремонта!"
	return
end

-- 한국어 할 줄 아세요?
if lang == "koKR" then
	L["Repair with guild bank funds"] = "길드 은행 자금으로 수리"
	L["Off"] = "끄기"
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
	L["g"] = {"골", " 골드"}
	L["s"] = {"실", " 실버"}
	L["c"] = {"코", " 코퍼"}
	L["Junk items sold for"] = "잡동사니 판매 금액:"
	L["Repaired for"] = "수리 비용:"
	L["Repaired from the guild bank for"] = "길드 은행 수리 비용:"
	L["Not enough money to automatically repair!"] = "자동 수리에 충분한 돈이 없습니다!"
	return
end

-- 你会说中文吗？
if lang == "zhCN" then
	L["Repair with guild bank funds"] = "使用公会银行资金修理"
	L["Off"] = "关闭"
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
	L["Junk items sold for"] = "出售垃圾物品所得："
	L["Repaired for"] = "修理费用："
	L["Repaired from the guild bank for"] = "公会银行修理费用："
	L["Not enough money to automatically repair!"] = "没有足够的钱自动修理！"
	return
end

-- 你會說中文嗎？
if lang == "zhTW" then
	L["Repair with guild bank funds"] = "使用公會銀行資金修理"
	L["Off"] = "關閉"
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
	L["Junk items sold for"] = "賣出垃圾物品獲得："
	L["Repaired for"] = "修理費用："
	L["Repaired from the guild bank for"] = "公會銀行修理費用："
	L["Not enough money to automatically repair!"] = "沒有足夠的金錢進行自動修理！"
	return
end

-- Você fala português?
if lang == "ptBR" then
	L["Repair with guild bank funds"] = "Reparar com o banco da guilda"
	L["Off"] = "Desativado"
	L["All the time"] = "Sempre"
	L["Only in a raid group"] = "Apenas em grupo de raide"
	L["Hold Modifier Key to prevent repairing"] = "Segure uma tecla modificadora para evitar o reparo"
	L["Show messages in chat"] = "Mostrar mensagens no chat"
	L["Currency display style:"] = "Estilo de exibição da moeda:"
	L["Error formatting money!"] = "Erro ao formatar o dinheiro!"
	L["Display Warning"] = "Aviso de exibição"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] = "A exibição de moedas pode apresentar falhas visuais.\nConsidere usar as opções de texto para uma exibição mais limpa."
	L["Coin icons"] = "Ícones de moedas"
	L["Short text"] = "Texto curto"
	L["Full text"] = "Texto completo"
	L["Use color formatting"] = "Usar formatação colorida"
	L["g"] = {"o", " ouro"}
	L["s"] = {"p", " prata"}
	L["c"] = {"c", " cobre"}
	L["Junk items sold for"] = "Lixo vendido por"
	L["Repaired for"] = "Reparado por"
	L["Repaired from the guild bank for"] = "Reparado com o banco da guilda por"
	L["Not enough money to automatically repair!"] = "Dinheiro insuficiente para reparo automático!"
	return
end

-- Parli italiano?
if lang == "itIT" then
	L["Repair with guild bank funds"] = "Ripara con la banca di gilda"
	L["Off"] = "Disattivato"
	L["All the time"] = "Sempre"
	L["Only in a raid group"] = "Solo in un gruppo di raid"
	L["Hold Modifier Key to prevent repairing"] = "Tieni premuto un tasto modificatore per evitare la riparazione"
	L["Show messages in chat"] = "Mostra messaggi in chat"
	L["Currency display style:"] = "Stile di visualizzazione della valuta:"
	L["Error formatting money!"] = "Errore nella formattazione del denaro!"
	L["Display Warning"] = "Avviso di visualizzazione"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] = "La visualizzazione delle monete potrebbe presentare artefatti visivi.\nConsidera di usare le opzioni testuali per una visualizzazione più pulita."
	L["Coin icons"] = "Icone delle monete"
	L["Short text"] = "Testo breve"
	L["Full text"] = "Testo completo"
	L["Use color formatting"] = "Usa la formattazione a colori"
	L["g"] = {"o", " oro"}
	L["s"] = {"a", " argento"}
	L["c"] = {"r", " rame"}
	L["Junk items sold for"] = "Cianfrusaglie vendute per"
	L["Repaired for"] = "Riparato per"
	L["Repaired from the guild bank for"] = "Riparato con la banca di gilda per"
	L["Not enough money to automatically repair!"] = "Non hai abbastanza denaro per riparare automaticamente!"
	return
end

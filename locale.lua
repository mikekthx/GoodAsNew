local _, ns = ...

local L = setmetatable({}, {
	__index = function(t, k)
		local v = tostring(k)
		rawset(t, k, v)
		return v
	end
})
ns.L = L

-- Coin labels can't fake it like the strings can, so English suits up first, just in case!
L["g"] = { "g", " Gold" }
L["s"] = { "s", " Silver" }
L["c"] = { "c", " Copper" }

-- Supported locales: enUS, enGB, deDE, esES, esMX, frFR, itIT, koKR, ptBR, ptPT, ruRU, zhCN, zhTW
local lang = GetLocale()

-- Do you speak English?
if lang == "enUS" or lang == "enGB" then
	L["Junk"] = "Junk"
	L["Sell junk automatically"] = "Sell junk automatically"
	L["Sells all gray-quality items when you open a vendor, the same as Blizzard's Sell All Junk button but without the confirmation. Bags set to ignore junk selling are left alone."] =
	"Sells all gray-quality items when you open a vendor, the same as Blizzard's Sell All Junk button but without the confirmation. Bags set to ignore junk selling are left alone."
	L["Repairs"] = "Repairs"
	L["Repair gear automatically"] = "Repair gear automatically"
	L["Repairs all of your gear when you visit a vendor that can repair."] = "Repairs all of your gear when you visit a vendor that can repair."
	L["Repair with guild bank funds"] = "Repair with guild bank funds"
	L["Uses guild bank funds for repairs when your guild rank allows it. If the guild can't cover the whole cost, you pay for the repair yourself."] =
	"Uses guild bank funds for repairs when your guild rank allows it. If the guild can't cover the whole cost, you pay for the repair yourself."
	L["Off"] = "Off"
	L["All the time"] = "All the time"
	L["Only in a raid group"] = "Only in a raid group"
	L["Hold Modifier Key to prevent repairing"] = "Hold Modifier Key to prevent repairing"
	L["Hold Shift, Ctrl, or Alt while opening a vendor to skip repairing for that visit. Junk is still sold."] =
	"Hold Shift, Ctrl, or Alt while opening a vendor to skip repairing for that visit. Junk is still sold."
	L["Chat"] = "Chat"
	L["Show messages in chat"] = "Show messages in chat"
	L["Prints how much your junk sold for and what repairs cost."] = "Prints how much your junk sold for and what repairs cost."
	L["Combine with Blizzard's money summary at vendors"] = "Combine with Blizzard's money summary at vendors"
	L["Adds this addon's junk-sold and repair totals onto Blizzard's own money message at vendors instead of printing them separately. Falls back to a separate message if nothing shows up to merge into within a couple seconds."] =
	"Adds this addon's junk-sold and repair totals onto Blizzard's own money message at vendors instead of printing them separately. Falls back to a separate message if nothing shows up to merge into within a couple seconds."
	L["Currency display style:"] = "Currency display style:"
	L["How money amounts are written in chat messages."] = "How money amounts are written in chat messages."
	L["Short text"] = "Short text"
	L["Full text"] = "Full text"
	L["Coin icons"] = "Coin icons"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] =
	"Coin display may have visual artifacts.\nConsider using text options for cleaner display."
	L["Use color formatting"] = "Use color formatting"
	L["Colors the money amounts in chat messages."] = "Colors the money amounts in chat messages."
	L["g"] = { "g", " Gold" }
	L["s"] = { "s", " Silver" }
	L["c"] = { "c", " Copper" }
	L["Junk sold for"] = "Junk sold for"
	L["Repaired for"] = "Repaired for"
	L["Repaired from the guild bank for"] = "Repaired from the guild bank for"
	L["Not enough money to automatically repair!"] = "Not enough money to automatically repair!"
	return
end

-- Sprichst du Deutsch?
if lang == "deDE" then
	L["Junk"] = "Plunder"
	L["Sell junk automatically"] = "Plunder automatisch verkaufen"
	L["Sells all gray-quality items when you open a vendor, the same as Blizzard's Sell All Junk button but without the confirmation. Bags set to ignore junk selling are left alone."] =
	"Verkauft beim Öffnen eines Händlers alle grauen Gegenstände, genau wie Blizzards Schaltfläche zum Verkaufen von Plunder, aber ohne Bestätigung. Taschen, die vom Plunderverkauf ausgenommen sind, bleiben unberührt."
	L["Repairs"] = "Reparaturen"
	L["Repair gear automatically"] = "Ausrüstung automatisch reparieren"
	L["Repairs all of your gear when you visit a vendor that can repair."] = "Repariert deine gesamte Ausrüstung, wenn du einen Händler besuchst, der reparieren kann."
	L["Repair with guild bank funds"] = "Mit Mitteln der Gildenbank reparieren"
	L["Uses guild bank funds for repairs when your guild rank allows it. If the guild can't cover the whole cost, you pay for the repair yourself."] =
	"Bezahlt Reparaturen aus der Gildenbank, wenn dein Gildenrang es erlaubt. Reichen die Mittel der Gilde nicht für die gesamten Kosten, bezahlst du die Reparatur selbst."
	L["Off"] = "Aus"
	L["All the time"] = "Immer"
	L["Only in a raid group"] = "Nur in einer Schlachtzugsgruppe"
	L["Hold Modifier Key to prevent repairing"] = "Reparatur mit gedrückter Modifikatortaste verhindern"
	L["Hold Shift, Ctrl, or Alt while opening a vendor to skip repairing for that visit. Junk is still sold."] =
	"Halte beim Öffnen eines Händlers Umschalt, Strg oder Alt gedrückt, um die Reparatur bei diesem Besuch zu überspringen. Plunder wird trotzdem verkauft."
	L["Chat"] = "Chat"
	L["Show messages in chat"] = "Nachrichten im Chat anzeigen"
	L["Prints how much your junk sold for and what repairs cost."] = "Zeigt an, wie viel dein Plunder eingebracht hat und was die Reparaturen gekostet haben."
	L["Combine with Blizzard's money summary at vendors"] = "Mit Blizzards Geldübersicht bei Händlern kombinieren"
	L["Adds this addon's junk-sold and repair totals onto Blizzard's own money message at vendors instead of printing them separately. Falls back to a separate message if nothing shows up to merge into within a couple seconds."] =
	"Fügt die Verkaufs- und Reparatursummen dieses Addons an Blizzards eigene Geldmeldung bei Händlern an, statt sie separat auszugeben. Greift auf eine separate Meldung zurück, falls innerhalb weniger Sekunden nichts zum Zusammenführen erscheint."
	L["Currency display style:"] = "Anzeigeformat der Währung:"
	L["How money amounts are written in chat messages."] = "Wie Geldbeträge in Chatnachrichten dargestellt werden."
	L["Short text"] = "Kurztext"
	L["Full text"] = "Volltext"
	L["Coin icons"] = "Münzsymbole"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] =
	"Die Anzeige von Münzsymbolen kann visuelle Artefakte enthalten.\nVerwende Textoptionen für eine sauberere Darstellung."
	L["Use color formatting"] = "Farbliche Darstellung verwenden"
	L["Colors the money amounts in chat messages."] = "Färbt Geldbeträge in Chatnachrichten ein."
	L["g"] = { "g", " Gold" }
	L["s"] = { "s", " Silber" }
	L["c"] = { "k", " Kupfer" }
	L["Junk sold for"] = "Plunder verkauft für"
	L["Repaired for"] = "Repariert für"
	L["Repaired from the guild bank for"] = "Mit Mitteln der Gildenbank repariert für"
	L["Not enough money to automatically repair!"] = "Nicht genug Geld zum automatischen Reparieren!"
	return
end

-- ¿Hablas español?
if lang == "esES" or lang == "esMX" then
	L["Junk"] = "Chatarra"
	L["Sell junk automatically"] = "Vender chatarra automáticamente"
	L["Sells all gray-quality items when you open a vendor, the same as Blizzard's Sell All Junk button but without the confirmation. Bags set to ignore junk selling are left alone."] =
	"Vende todos los objetos de calidad gris al abrir un mercader, igual que el botón de Blizzard para vender toda la chatarra, pero sin confirmación. Las bolsas marcadas para ignorar la venta de chatarra no se tocan."
	L["Repairs"] = "Reparaciones"
	L["Repair gear automatically"] = "Reparar equipo automáticamente"
	L["Repairs all of your gear when you visit a vendor that can repair."] = "Repara todo tu equipo al visitar un mercader que pueda reparar."
	L["Repair with guild bank funds"] = "Reparar con fondos del banco de hermandad"
	L["Uses guild bank funds for repairs when your guild rank allows it. If the guild can't cover the whole cost, you pay for the repair yourself."] =
	"Usa fondos del banco de hermandad para las reparaciones cuando tu rango lo permite. Si la hermandad no puede cubrir el coste completo, pagas tú la reparación."
	L["Off"] = "Desactivado"
	L["All the time"] = "Siempre"
	L["Only in a raid group"] = "Solo en una banda"
	L["Hold Modifier Key to prevent repairing"] = "Mantén una tecla modificadora para evitar la reparación"
	L["Hold Shift, Ctrl, or Alt while opening a vendor to skip repairing for that visit. Junk is still sold."] =
	"Mantén Mayús, Ctrl o Alt al abrir un mercader para omitir la reparación en esa visita. La chatarra se vende igualmente."
	L["Chat"] = "Chat"
	L["Show messages in chat"] = "Mostrar mensajes en el chat"
	L["Prints how much your junk sold for and what repairs cost."] = "Muestra cuánto obtuviste por la chatarra y cuánto costaron las reparaciones."
	L["Combine with Blizzard's money summary at vendors"] = "Combinar con el resumen de dinero de Blizzard en los mercaderes"
	L["Adds this addon's junk-sold and repair totals onto Blizzard's own money message at vendors instead of printing them separately. Falls back to a separate message if nothing shows up to merge into within a couple seconds."] =
	"Añade las sumas de chatarra vendida y reparaciones de este addon al propio mensaje de dinero de Blizzard en los mercaderes, en vez de mostrarlas por separado. Recurre a un mensaje por separado si no aparece nada con lo que combinarse en un par de segundos."
	L["Currency display style:"] = "Estilo de visualización de la moneda:"
	L["How money amounts are written in chat messages."] = "Cómo se muestran las cantidades de dinero en los mensajes del chat."
	L["Short text"] = "Texto corto"
	L["Full text"] = "Texto completo"
	L["Coin icons"] = "Iconos de monedas"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] =
	"La visualización de monedas puede tener artefactos visuales.\nConsidera usar las opciones de texto para una vista más limpia."
	L["Use color formatting"] = "Usar formato en color"
	L["Colors the money amounts in chat messages."] = "Colorea las cantidades de dinero en los mensajes del chat."
	L["g"] = { "o", " oro" }
	L["s"] = { "p", " plata" }
	L["c"] = { "c", " cobre" }
	L["Junk sold for"] = "Chatarra vendida por"
	L["Repaired for"] = "Reparado por"
	L["Repaired from the guild bank for"] = "Reparado con fondos del banco de hermandad por"
	L["Not enough money to automatically repair!"] = "¡No hay suficiente dinero para reparar automáticamente!"
	return
end

-- Parlez-vous français ?
if lang == "frFR" then
	L["Junk"] = "Camelote"
	L["Sell junk automatically"] = "Vendre la camelote automatiquement"
	L["Sells all gray-quality items when you open a vendor, the same as Blizzard's Sell All Junk button but without the confirmation. Bags set to ignore junk selling are left alone."] =
	"Vend tous les objets de qualité grise à l’ouverture d’un marchand, comme le bouton de Blizzard pour vendre toute la camelote, mais sans confirmation. Les sacs exclus de la vente de camelote ne sont pas touchés."
	L["Repairs"] = "Réparations"
	L["Repair gear automatically"] = "Réparer l’équipement automatiquement"
	L["Repairs all of your gear when you visit a vendor that can repair."] = "Répare tout votre équipement lorsque vous visitez un marchand capable de réparer."
	L["Repair with guild bank funds"] = "Réparer avec les fonds de la banque de guilde"
	L["Uses guild bank funds for repairs when your guild rank allows it. If the guild can't cover the whole cost, you pay for the repair yourself."] =
	"Utilise les fonds de la banque de guilde pour les réparations si votre rang le permet. Si la guilde ne peut pas couvrir tout le coût, vous payez la réparation vous-même."
	L["Off"] = "Désactivé"
	L["All the time"] = "Toujours"
	L["Only in a raid group"] = "Uniquement en groupe de raid"
	L["Hold Modifier Key to prevent repairing"] = "Maintenir une touche modificatrice pour bloquer la réparation"
	L["Hold Shift, Ctrl, or Alt while opening a vendor to skip repairing for that visit. Junk is still sold."] =
	"Maintenez Maj, Ctrl ou Alt en ouvrant un marchand pour ne pas réparer lors de cette visite. La camelote est tout de même vendue."
	L["Chat"] = "Chat"
	L["Show messages in chat"] = "Afficher les messages dans le chat"
	L["Prints how much your junk sold for and what repairs cost."] = "Affiche combien votre camelote a rapporté et combien ont coûté les réparations."
	L["Combine with Blizzard's money summary at vendors"] = "Combiner avec le résumé d’argent de Blizzard chez les marchands"
	L["Adds this addon's junk-sold and repair totals onto Blizzard's own money message at vendors instead of printing them separately. Falls back to a separate message if nothing shows up to merge into within a couple seconds."] =
	"Ajoute les sommes de camelote vendue et de réparations de cet addon au message d’argent de Blizzard chez les marchands, au lieu de les afficher séparément. Bascule sur un message séparé si rien n’apparaît pour fusionner en quelques secondes."
	L["Currency display style:"] = "Style d’affichage de la monnaie :"
	L["How money amounts are written in chat messages."] = "Façon dont les montants sont affichés dans les messages du chat."
	L["Short text"] = "Texte court"
	L["Full text"] = "Texte complet"
	L["Coin icons"] = "Icônes de pièces"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] =
	"L’affichage des pièces peut provoquer des artefacts visuels.\nUtilisez une option textuelle pour un affichage plus propre."
	L["Use color formatting"] = "Utiliser la mise en couleur"
	L["Colors the money amounts in chat messages."] = "Colore les montants dans les messages du chat."
	L["g"] = { "po", " or" }
	L["s"] = { "pa", " argent" }
	L["c"] = { "pc", " cuivre" }
	L["Junk sold for"] = "Camelote vendue pour"
	L["Repaired for"] = "Réparé pour"
	L["Repaired from the guild bank for"] = "Réparé avec les fonds de la banque de guilde pour"
	L["Not enough money to automatically repair!"] = "Pas assez d'argent pour réparer automatiquement !"
	return
end

-- Parli italiano?
if lang == "itIT" then
	L["Junk"] = "Cianfrusaglie"
	L["Sell junk automatically"] = "Vendi automaticamente le cianfrusaglie"
	L["Sells all gray-quality items when you open a vendor, the same as Blizzard's Sell All Junk button but without the confirmation. Bags set to ignore junk selling are left alone."] =
	"Vende tutti gli oggetti di qualità grigia quando apri un mercante, come il pulsante di Blizzard per vendere tutte le cianfrusaglie, ma senza conferma. Le borse escluse dalla vendita delle cianfrusaglie non vengono toccate."
	L["Repairs"] = "Riparazioni"
	L["Repair gear automatically"] = "Ripara automaticamente l'equipaggiamento"
	L["Repairs all of your gear when you visit a vendor that can repair."] = "Ripara tutto il tuo equipaggiamento quando visiti un mercante in grado di riparare."
	L["Repair with guild bank funds"] = "Ripara con i fondi della banca di gilda"
	L["Uses guild bank funds for repairs when your guild rank allows it. If the guild can't cover the whole cost, you pay for the repair yourself."] =
	"Usa i fondi della banca di gilda per le riparazioni quando il tuo grado lo consente. Se la gilda non può coprire l'intero costo, paghi tu la riparazione."
	L["Off"] = "Disattivato"
	L["All the time"] = "Sempre"
	L["Only in a raid group"] = "Solo in un gruppo d'incursione"
	L["Hold Modifier Key to prevent repairing"] = "Tieni premuto un tasto modificatore per evitare la riparazione"
	L["Hold Shift, Ctrl, or Alt while opening a vendor to skip repairing for that visit. Junk is still sold."] =
	"Tieni premuto Maiusc, Ctrl o Alt mentre apri un mercante per saltare la riparazione in quella visita. Le cianfrusaglie vengono comunque vendute."
	L["Chat"] = "Chat"
	L["Show messages in chat"] = "Mostra messaggi in chat"
	L["Prints how much your junk sold for and what repairs cost."] = "Mostra quanto hai ricavato dalle cianfrusaglie e quanto sono costate le riparazioni."
	L["Combine with Blizzard's money summary at vendors"] = "Combina con il riepilogo del denaro di Blizzard dai mercanti"
	L["Adds this addon's junk-sold and repair totals onto Blizzard's own money message at vendors instead of printing them separately. Falls back to a separate message if nothing shows up to merge into within a couple seconds."] =
	"Aggiunge gli importi della vendita delle cianfrusaglie e delle riparazioni di questo addon al messaggio di denaro di Blizzard presso i mercanti, invece di mostrarli separatamente. Passa a un messaggio separato se non compare nulla con cui unirsi entro un paio di secondi."
	L["Currency display style:"] = "Stile di visualizzazione della valuta:"
	L["How money amounts are written in chat messages."] = "Come vengono mostrati gli importi di denaro nei messaggi di chat."
	L["Short text"] = "Testo breve"
	L["Full text"] = "Testo completo"
	L["Coin icons"] = "Icone delle monete"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] =
	"La visualizzazione delle monete potrebbe presentare artefatti visivi.\nConsidera di usare le opzioni testuali per una visualizzazione più pulita."
	L["Use color formatting"] = "Usa la formattazione a colori"
	L["Colors the money amounts in chat messages."] = "Colora gli importi di denaro nei messaggi di chat."
	L["g"] = { "o", " oro" }
	L["s"] = { "a", " argento" }
	L["c"] = { "r", " rame" }
	L["Junk sold for"] = "Cianfrusaglie vendute per"
	L["Repaired for"] = "Riparato per"
	L["Repaired from the guild bank for"] = "Riparato con i fondi della banca di gilda per"
	L["Not enough money to automatically repair!"] = "Non hai abbastanza denaro per riparare automaticamente!"
	return
end

-- 한국어 할 줄 아세요?
if lang == "koKR" then
	L["Junk"] = "잡동사니"
	L["Sell junk automatically"] = "잡동사니 자동 판매"
	L["Sells all gray-quality items when you open a vendor, the same as Blizzard's Sell All Junk button but without the confirmation. Bags set to ignore junk selling are left alone."] =
	"상인 창을 열면 회색 등급 아이템을 모두 판매합니다. 블리자드의 잡동사니 일괄 판매 버튼과 같지만 확인 창이 없습니다. 잡동사니 판매에서 제외된 가방은 건드리지 않습니다."
	L["Repairs"] = "수리"
	L["Repair gear automatically"] = "장비 자동 수리"
	L["Repairs all of your gear when you visit a vendor that can repair."] = "수리가 가능한 상인을 방문하면 모든 장비를 수리합니다."
	L["Repair with guild bank funds"] = "길드 은행 자금으로 수리"
	L["Uses guild bank funds for repairs when your guild rank allows it. If the guild can't cover the whole cost, you pay for the repair yourself."] =
	"길드 등급이 허용하면 길드 은행 자금으로 수리합니다. 길드 자금으로 전체 비용을 충당할 수 없으면 수리 비용을 본인이 지불합니다."
	L["Off"] = "끄기"
	L["All the time"] = "항상"
	L["Only in a raid group"] = "공격대일 때만"
	L["Hold Modifier Key to prevent repairing"] = "조합 키를 누른 채로 수리 방지"
	L["Hold Shift, Ctrl, or Alt while opening a vendor to skip repairing for that visit. Junk is still sold."] =
	"상인 창을 열 때 Shift, Ctrl 또는 Alt 키를 누르고 있으면 이번 방문에서는 수리하지 않습니다. 잡동사니는 그대로 판매됩니다."
	L["Chat"] = "채팅"
	L["Show messages in chat"] = "채팅에 메시지 표시"
	L["Prints how much your junk sold for and what repairs cost."] = "잡동사니 판매 금액과 수리 비용을 표시합니다."
	L["Combine with Blizzard's money summary at vendors"] = "상인 창에서 블리자드 화폐 요약과 통합"
	L["Adds this addon's junk-sold and repair totals onto Blizzard's own money message at vendors instead of printing them separately. Falls back to a separate message if nothing shows up to merge into within a couple seconds."] =
	"이 애드온의 잡동사니 판매 및 수리 금액을 별도로 표시하는 대신 상인 창에서 블리자드의 화폐 메시지에 추가합니다. 몇 초 내에 병합할 대상이 나타나지 않으면 별도의 메시지로 표시됩니다."
	L["Currency display style:"] = "통화 표시 형식:"
	L["How money amounts are written in chat messages."] = "채팅 메시지에서 금액을 표시하는 방식입니다."
	L["Short text"] = "짧은 텍스트"
	L["Full text"] = "전체 텍스트"
	L["Coin icons"] = "동전 아이콘"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] =
	"동전 아이콘 표시 시 시각적 결함이 있을 수 있습니다.\n더 깔끔한 표시를 위해 텍스트 옵션을 고려하세요."
	L["Use color formatting"] = "색상 형식 사용"
	L["Colors the money amounts in chat messages."] = "채팅 메시지의 금액에 색상을 적용합니다."
	L["g"] = { "골", " 골드" }
	L["s"] = { "실", " 실버" }
	L["c"] = { "동", " 동" }
	L["Junk sold for"] = "잡동사니 판매 금액:"
	L["Repaired for"] = "수리 비용:"
	L["Repaired from the guild bank for"] = "길드 은행 수리 비용:"
	L["Not enough money to automatically repair!"] = "자동 수리에 충분한 돈이 없습니다!"
	return
end

-- Você fala português?
if lang == "ptBR" or lang == "ptPT" then
	L["Junk"] = "Lixo"
	L["Sell junk automatically"] = "Vender lixo automaticamente"
	L["Sells all gray-quality items when you open a vendor, the same as Blizzard's Sell All Junk button but without the confirmation. Bags set to ignore junk selling are left alone."] =
	"Vende todos os itens de qualidade cinza ao abrir um mercador, como o botão da Blizzard de vender todo o lixo, mas sem confirmação. Bolsas marcadas para ignorar a venda de lixo não são afetadas."
	L["Repairs"] = "Reparos"
	L["Repair gear automatically"] = "Reparar equipamento automaticamente"
	L["Repairs all of your gear when you visit a vendor that can repair."] = "Repara todo o seu equipamento ao visitar um mercador que possa reparar."
	L["Repair with guild bank funds"] = "Reparar com fundos do banco da guilda"
	L["Uses guild bank funds for repairs when your guild rank allows it. If the guild can't cover the whole cost, you pay for the repair yourself."] =
	"Usa fundos do banco da guilda para reparos quando sua patente permite. Se a guilda não puder cobrir o custo total, você mesmo paga o reparo."
	L["Off"] = "Desativado"
	L["All the time"] = "Sempre"
	L["Only in a raid group"] = "Apenas em grupo de raide"
	L["Hold Modifier Key to prevent repairing"] = "Segure uma tecla modificadora para evitar o reparo"
	L["Hold Shift, Ctrl, or Alt while opening a vendor to skip repairing for that visit. Junk is still sold."] =
	"Segure Shift, Ctrl ou Alt ao abrir um mercador para pular o reparo nessa visita. O lixo ainda é vendido."
	L["Chat"] = "Chat"
	L["Show messages in chat"] = "Mostrar mensagens no chat"
	L["Prints how much your junk sold for and what repairs cost."] = "Mostra quanto seu lixo rendeu e quanto custaram os reparos."
	L["Combine with Blizzard's money summary at vendors"] = "Combinar com o resumo de dinheiro da Blizzard nos mercadores"
	L["Adds this addon's junk-sold and repair totals onto Blizzard's own money message at vendors instead of printing them separately. Falls back to a separate message if nothing shows up to merge into within a couple seconds."] =
	"Adiciona os totais de lixo vendido e reparos deste addon à própria mensagem de dinheiro da Blizzard nos mercadores, em vez de exibi-los separadamente. Recorre a uma mensagem separada se nada aparecer para mesclar em poucos segundos."
	L["Currency display style:"] = "Estilo de exibição da moeda:"
	L["How money amounts are written in chat messages."] = "Como os valores em dinheiro aparecem nas mensagens do chat."
	L["Short text"] = "Texto curto"
	L["Full text"] = "Texto completo"
	L["Coin icons"] = "Ícones de moedas"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] =
	"A exibição de moedas pode apresentar falhas visuais.\nConsidere usar as opções de texto para uma exibição mais limpa."
	L["Use color formatting"] = "Usar formatação colorida"
	L["Colors the money amounts in chat messages."] = "Colore os valores em dinheiro nas mensagens do chat."
	L["g"] = { "o", " ouro" }
	L["s"] = { "p", " prata" }
	L["c"] = { "c", " cobre" }
	L["Junk sold for"] = "Lixo vendido por"
	L["Repaired for"] = "Reparado por"
	L["Repaired from the guild bank for"] = "Reparado com fundos do banco da guilda por"
	L["Not enough money to automatically repair!"] = "Dinheiro insuficiente para reparo automático!"
	return
end

-- Вы говорите по-русски?
if lang == "ruRU" then
	L["Junk"] = "Хлам"
	L["Sell junk automatically"] = "Автоматически продавать хлам"
	L["Sells all gray-quality items when you open a vendor, the same as Blizzard's Sell All Junk button but without the confirmation. Bags set to ignore junk selling are left alone."] =
	"Продаёт все предметы серого качества при открытии окна торговца — так же, как кнопка Blizzard для продажи всего хлама, но без подтверждения. Сумки, исключённые из продажи хлама, не затрагиваются."
	L["Repairs"] = "Ремонт"
	L["Repair gear automatically"] = "Автоматически ремонтировать снаряжение"
	L["Repairs all of your gear when you visit a vendor that can repair."] = "Ремонтирует всё снаряжение при посещении торговца, который может чинить."
	L["Repair with guild bank funds"] = "Ремонт за счет банка гильдии"
	L["Uses guild bank funds for repairs when your guild rank allows it. If the guild can't cover the whole cost, you pay for the repair yourself."] =
	"Оплачивает ремонт из банка гильдии, если это позволяет ваше звание. Если средств гильдии не хватает на всю сумму, ремонт оплачиваете вы сами."
	L["Off"] = "Выключено"
	L["All the time"] = "Всегда"
	L["Only in a raid group"] = "Только в рейде"
	L["Hold Modifier Key to prevent repairing"] = "Удерживайте клавишу-модификатор, чтобы предотвратить ремонт"
	L["Hold Shift, Ctrl, or Alt while opening a vendor to skip repairing for that visit. Junk is still sold."] =
	"Удерживайте Shift, Ctrl или Alt при открытии окна торговца, чтобы пропустить ремонт в этот раз. Хлам всё равно будет продан."
	L["Chat"] = "Чат"
	L["Show messages in chat"] = "Показывать сообщения в чате"
	L["Prints how much your junk sold for and what repairs cost."] = "Показывает, сколько принёс проданный хлам и сколько стоил ремонт."
	L["Combine with Blizzard's money summary at vendors"] = "Объединять со стандартной сводкой денег у торговцев"
	L["Adds this addon's junk-sold and repair totals onto Blizzard's own money message at vendors instead of printing them separately. Falls back to a separate message if nothing shows up to merge into within a couple seconds."] =
	"Добавляет суммы за проданный хлам и ремонт этого аддона к собственному сообщению Blizzard о деньгах у торговцев вместо отдельного вывода. Возвращается к отдельному сообщению, если в течение пары секунд не появится ничего для объединения."
	L["Currency display style:"] = "Стиль отображения валюты:"
	L["How money amounts are written in chat messages."] = "Как суммы денег отображаются в сообщениях чата."
	L["Short text"] = "Краткий текст"
	L["Full text"] = "Полный текст"
	L["Coin icons"] = "Значки монет"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] =
	"Отображение монет может содержать визуальные артефакты.\nРекомендуется использовать текстовый режим для чистоты отображения."
	L["Use color formatting"] = "Использовать цветное оформление"
	L["Colors the money amounts in chat messages."] = "Выделяет цветом суммы денег в сообщениях чата."
	L["g"] = { "з", " золота" }
	L["s"] = { "с", " серебра" }
	L["c"] = { "м", " меди" }
	L["Junk sold for"] = "Хлам продан за"
	L["Repaired for"] = "Отремонтировано за"
	L["Repaired from the guild bank for"] = "Отремонтировано за счет банка гильдии за"
	L["Not enough money to automatically repair!"] = "Недостаточно денег для автоматического ремонта!"
	return
end

-- 你会说中文吗？
if lang == "zhCN" then
	L["Junk"] = "垃圾物品"
	L["Sell junk automatically"] = "自动出售垃圾"
	L["Sells all gray-quality items when you open a vendor, the same as Blizzard's Sell All Junk button but without the confirmation. Bags set to ignore junk selling are left alone."] =
	"打开商人界面时出售所有灰色品质物品，与暴雪的出售全部垃圾按钮相同，但没有确认提示。设置为不出售垃圾的背包不受影响。"
	L["Repairs"] = "修理"
	L["Repair gear automatically"] = "自动修理装备"
	L["Repairs all of your gear when you visit a vendor that can repair."] = "访问可以修理的商人时修理你的所有装备。"
	L["Repair with guild bank funds"] = "使用公会银行资金修理"
	L["Uses guild bank funds for repairs when your guild rank allows it. If the guild can't cover the whole cost, you pay for the repair yourself."] =
	"在公会会阶允许时使用公会银行资金修理。如果公会资金不足以支付全部费用，将由你自己支付修理费用。"
	L["Off"] = "关闭"
	L["All the time"] = "总是"
	L["Only in a raid group"] = "仅在团队中"
	L["Hold Modifier Key to prevent repairing"] = "按住修饰键以阻止修理"
	L["Hold Shift, Ctrl, or Alt while opening a vendor to skip repairing for that visit. Junk is still sold."] =
	"打开商人界面时按住Shift、Ctrl或Alt键可跳过本次修理。垃圾仍会被出售。"
	L["Chat"] = "聊天"
	L["Show messages in chat"] = "在聊天中显示信息"
	L["Prints how much your junk sold for and what repairs cost."] = "显示出售垃圾的收入和修理费用。"
	L["Combine with Blizzard's money summary at vendors"] = "在商人处与暴雪的金钱汇总合并显示"
	L["Adds this addon's junk-sold and repair totals onto Blizzard's own money message at vendors instead of printing them separately. Falls back to a separate message if nothing shows up to merge into within a couple seconds."] =
	"在商人处将本插件出售垃圾和修理的金额附加到暴雪自身的金钱提示中，而不是单独显示。如果在几秒内未出现可合并的内容，将恢复单独显示。"
	L["Currency display style:"] = "货币显示样式："
	L["How money amounts are written in chat messages."] = "聊天信息中金额的显示方式。"
	L["Short text"] = "简短文本"
	L["Full text"] = "完整文本"
	L["Coin icons"] = "硬币图标"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] =
	"硬币图标显示可能存在视觉问题。\n建议使用文本样式以获得更清晰的显示效果。"
	L["Use color formatting"] = "使用颜色格式"
	L["Colors the money amounts in chat messages."] = "为聊天信息中的金额着色。"
	L["g"] = { "金", " 金币" }
	L["s"] = { "银", " 银币" }
	L["c"] = { "铜", " 铜币" }
	L["Junk sold for"] = "出售垃圾所得："
	L["Repaired for"] = "修理费用："
	L["Repaired from the guild bank for"] = "公会银行修理费用："
	L["Not enough money to automatically repair!"] = "没有足够的钱自动修理！"
	return
end

-- 你會說中文嗎？
if lang == "zhTW" then
	L["Junk"] = "垃圾物品"
	L["Sell junk automatically"] = "自動販售垃圾"
	L["Sells all gray-quality items when you open a vendor, the same as Blizzard's Sell All Junk button but without the confirmation. Bags set to ignore junk selling are left alone."] =
	"開啟商人介面時販售所有灰色品質物品，與暴雪的販售所有垃圾按鈕相同，但沒有確認提示。設定為不販售垃圾的背包不受影響。"
	L["Repairs"] = "修理"
	L["Repair gear automatically"] = "自動修理裝備"
	L["Repairs all of your gear when you visit a vendor that can repair."] = "拜訪可以修理的商人時修理你的所有裝備。"
	L["Repair with guild bank funds"] = "使用公會銀行資金修理"
	L["Uses guild bank funds for repairs when your guild rank allows it. If the guild can't cover the whole cost, you pay for the repair yourself."] =
	"在公會階級允許時使用公會銀行資金修理。如果公會資金不足以支付全部費用，將由你自己支付修理費用。"
	L["Off"] = "關閉"
	L["All the time"] = "總是"
	L["Only in a raid group"] = "僅限團隊中"
	L["Hold Modifier Key to prevent repairing"] = "按住組合鍵以避免修理"
	L["Hold Shift, Ctrl, or Alt while opening a vendor to skip repairing for that visit. Junk is still sold."] =
	"開啟商人介面時按住Shift、Ctrl或Alt鍵可略過本次修理。垃圾仍會被販售。"
	L["Chat"] = "聊天"
	L["Show messages in chat"] = "在聊天中顯示訊息"
	L["Prints how much your junk sold for and what repairs cost."] = "顯示販售垃圾的收入和修理費用。"
	L["Combine with Blizzard's money summary at vendors"] = "在商人處與暴雪的金錢彙總合併顯示"
	L["Adds this addon's junk-sold and repair totals onto Blizzard's own money message at vendors instead of printing them separately. Falls back to a separate message if nothing shows up to merge into within a couple seconds."] =
	"在商人處將本插件出售垃圾和修理的金額附加到暴雪自身的金錢提示中，而不是單獨顯示。如果在幾秒內未出現可合併的內容，將恢復單獨顯示。"
	L["Currency display style:"] = "貨幣顯示樣式："
	L["How money amounts are written in chat messages."] = "聊天訊息中金額的顯示方式。"
	L["Short text"] = "簡短文字"
	L["Full text"] = "完整文字"
	L["Coin icons"] = "硬幣圖示"
	L["Coin display may have visual artifacts.\nConsider using text options for cleaner display."] =
	"硬幣圖示顯示可能會產生視覺異常。\n建議使用文字選項以獲得更清晰的顯示效果。"
	L["Use color formatting"] = "使用顏色格式"
	L["Colors the money amounts in chat messages."] = "為聊天訊息中的金額著色。"
	L["g"] = { "金", " 金幣" }
	L["s"] = { "銀", " 銀幣" }
	L["c"] = { "銅", " 銅幣" }
	L["Junk sold for"] = "賣出垃圾獲得："
	L["Repaired for"] = "修理費用："
	L["Repaired from the guild bank for"] = "公會銀行修理費用："
	L["Not enough money to automatically repair!"] = "沒有足夠的金錢進行自動修理！"
	return
end

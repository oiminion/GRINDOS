extends CanvasLayer

signal finished_talk

var page :int = 0
var can_go_next :bool = false
var auto :bool = false

var string_array :Array

func setStringArray(strings :Array) -> void:
	string_array = strings
	page = 0
	self.visible = true
	updateText(string_array[0])

func nextText() -> void:
	page += 1
	if page == string_array.size():
		self.visible = false
		finished_talk.emit()
	elif can_go_next:
		updateText(string_array[page])

func changeDelay(delay :float) -> void:
	$Timer.wait_time = delay

func skipText() -> void:
	$Panel/RichTextLabel.visible_ratio = 1
	can_go_next = true

func updateText(input: String) -> void:
	$TextureRect.visible = true
	can_go_next = false
	$Panel/RichTextLabel.text = input
	$Panel/RichTextLabel.visible_characters = 0
	$Timer.start()

func _on_timer_timeout() -> void:
	if $Panel/RichTextLabel.visible_characters < $Panel/RichTextLabel.text.length() and not can_go_next:
		$Panel/RichTextLabel.visible_characters += 1
		$Timer.start()
	else:
		can_go_next = true
		if auto:
			$AutoDelay.start()

func _on_next_button_button_down() -> void:
	if can_go_next:
		nextText()
	else:
		skipText()

func _ready() -> void:
	var array: Array = ["Não sei se eu tô certo ou se eu tô errado
Mas faço tudo o que eu digo e digo tudo que eu faço
Neste mundo eu sou eu você é você
Faça tudo o que quiser porque eu também vou fazer
Não sei mais o que faço
Eu já fumei dez maços
Mandei tudo pro espaço
Agora eu só quero paz
Cansei dessa gente desse papo furado
Viajei por todo o mundo pra ficar descansado
Mas nada feito, o meu problema foi sempre você
Diga tudo o que quiser, pois eu preciso saber
Não sei mais o que faço
Já fumei dez maços
Mandei tudo pro espaço
Agora eu só quero paz
Não sei se eu tô certo ou se eu tô errado
Mas faço tudo o que eu digo e digo tudo que eu faço
Neste mundo eu sou eu você é você
Faça tudo o que quiser porque eu também vou fazer
Não sei mais o que faço
Eu já fumei dez maços
Mandei tudo pro espaço
Agora eu só quero paz
Quero paz
Quero paz
Quero paz",
"Edson Arantes do Nascimento, o Pelé, é um ex-esportista brasileiro, considerado o maior jogador da história do futebol, personalidade mundial do esporte e popularmente chamado de Rei do Futebol. Nasceu na cidade de Três Corações, em Minas Gerais, no dia 23 de outubro de 1940. É filho de João Ramos do Nascimento (também ex-jogador de futebol, conhecido como Dondinho) e Celeste Arantes do Nascimento. Morreu aos 82 anos, em 29 de dezembro de 2022, em São Paulo.
Aos quatro anos de idade, Edson e sua família mudaram-se para Bauru, em São Paulo. Nessa época, ele era chamado de Dico pela família e de Edson pelos amigos. Influenciado pelo pai, Dico sempre foi fã de futebol e logo começou a fazer parte dos times de garotos que jogavam nas ruas de Bauru. Ele gostava de atuar no gol, inspirado no goleiro José Lino da Conceição Faustino, o Bilé, amigo de time de seu pai, o Vasco de São Lourenço (Minas Gerais).",
"perdi",
"batata"]
	setStringArray(array)


func _on_skip_button_button_down() -> void:
	skipText()
	nextText()


func _on_auto_delay_timeout() -> void:
	nextText()

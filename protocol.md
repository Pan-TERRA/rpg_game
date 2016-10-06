#Протокол RPG(клиент-сервер)

[TOC]

Формат: json

###Запрос на инициализацию боя
Запрашивается один раз при инициализации боя.
```
{
	"type": "BATTLE_INIT",
	"token": *
}
```

###Ответ при инициализации боя
Отправляется один раз при инициализации боя, отправляется каждому игроку свой.
`"hp"` по всегда `100`, но ,возможно, в будущем будет фича, где у персов изначально не полное здоровье.

*Надо ли тут что-то для валидации сделать?*

```
{
	"type": "BATTLE_INIT",
	"opponent_info": {
		"nick": string,
		"hp": 0 - 100	
	},
	"is_current_turn": "true"/"false"
}
```

####Примеры:

```
{
	"type": "BATTLE_INIT",
	"token": "sadfsadf435kj3h45khjhf8y134dsaasfddfd"
}
```

```
{
	"type": "BATTLE_INIT",
	"opponent_info": {
		"nick": "nogibator",
		"hp": 100
	},
	"is_current_turn": "false"
}
```

------------

###Запрос на получение battle_condition
Запрашивается при задержке или если ответ от сервера(battle_condition) не прошел валидацию.
```
{
	"type": "BATTLE_CONDITION",
	"token": *
}
```

###Ответ battle_condition
Отправляется после любого SPELL_ACTION.
```
{
	"hp": 0 - 100,
	"opponent_hp": 0 - 100,
	"spells_condition": [
		{
			"id": *,
			"cooldown": *
		},	
	]
}
```

###Ответ battle_condition(при победе)
Отправляется после любого SPELL_ACTION. Победа высчитывается на клиенте, то есть клиент чекает хп. Добавляем `"reward"`, который потом просто отобразим.
```
{
	"hp": 0 - 100,
	"opponent_hp": 0 - 100,
	"spells_condition": [
		{
			"id": *,
			"cooldown": *
		},
	],
	"reward": {
		"gold": 0 - *,
		"kruglyashi": 0 - *
	} 
}
```

####Примеры:

```
{
	"type": "BATTLE_CONDITION",
	"token": *
}
```

```
{
	"hp": 0 - 100,
	"opponent_hp": 0 - 100,
	"spells_condition": [
		{
			"id": 54534,
			"cooldown": 60
		},
		{
			"id": 3455,
			"cooldown": 20
		}
	]
}
```

```
{
	"hp": 35,
	"opponent_hp": 0,
	"spells_condition": [
		{
			"id": 54534,
			"cooldown": 60
		}
	],
	"reward": {
		"gold": 100,
		"kruglyashi": 200
	} 
}
```

----------

###Запрос на action(спелл)
Запрашивается при использовании какого-то спелла.
```
{
	"token": *
	"type": "SPELL_ACTION",
	"spell_id": *
}
```

###Ответ на action(спелл)
Отвечает BATTLE_CONDITION.

####Примеры:

```
{
	"token": "dsafasdghjkladhglkh35hkhsadf",
	"type": "SPELL_ACTION",
	"spell_id": 53453
}
```

-----

###Запрос  времени

```
{
	"token": *,
	"type": "TIME_REQUEST"
}
```

####Примеры

```
{
	"token": "sdfasdfadsji43yu6khasd",
	"type": "TIME_REQUEST"
}
```

 


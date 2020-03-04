# Портированная Flash игра на HTML5 (OpenFL)

Описание
------------------------------

В качестве демонстраций перенёс Flash игру на HTML5.
Поиграть можно [тут](https://funnycarrot.ru/games/flipit/ "Перейти на сайт с игрой").

Запуск
------------------------------

Это html5 игра, поэтому, для её запуска нужно использовать браузер. Файлы игры необходимо разместить на самом простом web сервере, который умеет раздавать статику.

Для запуска сервера игры на localhost, вы можете установить [NodeJS](https://nodejs.org/en/ "NodeJS"), а затем выполнить команду для установки web-сервера:
`npm install http-server -g`

Запуск сервера:
`cd D:\Folder`
`http-server`

Или:
`http-server D:\Folder`

Корень web-сервера должен быть запущен в папке с расположением файла: *index.html*.
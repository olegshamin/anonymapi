# anonymapi

- ServiceLocator для инициализации сервисов
- Координаторы для перехода между экранами
- Каждый сервис состоит из NetworkRepository и DatabaseRepository, каждый репозиторий имеет NetworkLayer или DatabaseLayer, соответственно. (Слой БД не реализован)
- UIImageLoader для кеширования изоражений
- немного юнит тестов
- так как документация к серверу отсутствовала, я предположил, что все переменные в API моделях - optional
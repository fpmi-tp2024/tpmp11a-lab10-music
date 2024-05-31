# Дополнительная спецификация

[Home](index.md)    
[Функциональные требования](functionalRequirements.md)  
[Спецификация](specification.md)  
[Диаграмма файлов приложения](filesSchema.md)   
[Дополнительная спецификация](dopSpecification.md)          
[Презентация проекта](projectPresentation.md)

# Дополнительная спецификация

Ограничения
--------------

1. **Платформа**: Приложение MusicCourseFinder должно быть разработано для мобильных устройств на базе iOS.
2. **Версия iOS**: Приложение должно поддерживать версии iOS, начиная с 13.0.
3. **Устройства**: Приложение должно быть оптимизировано для работы на iPhone, iPad и iPod touch.

Требования к безопасности
--------------------------

1. **Аутентификация**: Для доступа к некоторым функциям приложения пользователям необходимо пройти аутентификацию. Для этого можно использовать почту и пароль, либо аккаунты социальных сетей (Facebook, Google, и т.д.).
2. **Защита данных**: Все данные, хранящиеся в приложении, должны быть защищены с помощью шифрования. При передаче данных по сети необходимо использовать протоколы безопасного соединения, такие как HTTPS.

Требования к надежности
------------------------

1. **Обработка ошибок**: Приложение должно корректно обрабатывать различные типы ошибок, включая сетевые, вводные и логические. В случае возникновения ошибки пользователю должно выводиться соответствующее сообщение.
2. **Восстановление после сбоев**: Приложение должно быть способно восстанавливаться после сбоев и непредвиденных ситуаций, таких как потеря соединения с сетью или отключение питания.
3. **Сохранение данных**: Все данные, введенные или измененные пользователем, должны автоматически сохраняться в приложении. Это гарантирует, что данные не будут потеряны в случае сбоя или непредвиденной ситуации.

Другие требования
------------------

1. **Масштабируемость**: Приложение должно быть разработано с учетом будущего роста и масштабирования, включая поддержку большего количества пользователей и ресурсов.
# CheckDev Docker Compose

Полный стек CheckDev — 7 микросервисов + PostgreSQL в Docker Compose.

## Архитектура

postgres — PostgreSQL 16 с 5 БД: cd_auth, cd_desc, cd_generator, mock, cd_notification (порт 5432)
eureka — Service Discovery (порт 9009)
auth — Аутентификация (порт 9900)
desc — Описания (порт 9902)
generator — Генератор статистики (порт 9903)
mock — Пробные собеседования (порт 9912)
notification — Уведомления (порт 9920)
site — Фронтенд CheckDev (порт 8080)

## Быстрый старт

Запустить все сервисы одной командой:

docker compose up -d

## Проверка работы

Сайт: http://localhost:8080
Eureka UI: http://localhost:9009

В Eureka UI должны быть зарегистрированы 6 сервисов: AUTH, DESC, GENERATOR, MOCK, NOTIFICATION, SITE — все в статусе UP.

## Остановка

docker compose down

Данные PostgreSQL сохраняются в postgres-data/ и переживают перезапуск.

## Структура

checkdev-deploy/
  docker-compose.yml    — описание всех сервисов
  init-db.sh            — создаёт 5 БД при первом запуске
  postgres-data/        — данные PostgreSQL (в .gitignore)
  README.md

## Требования

Docker 20+
Docker Compose v2
4 GB RAM (для запуска всех сервисов)

## Микросервисы

Каждый сервис — отдельный репозиторий:

cd-auth — аутентификация
cd-eureka — service discovery
cd-desc — описания
cd-generator — статистика
cd-mock — пробные собеседования
cd-notification — уведомления
cd-site — фронтенд

## Как это работает

1. PostgreSQL стартует первым, init-db.sh создаёт 5 БД
2. Eureka стартует, ждёт регистрации сервисов
3. Auth, Desc, Generator, Mock, Notification стартуют параллельно и регистрируются в Eureka
4. Site стартует последним (зависит от остальных) — использует их через Eureka

Все сервисы работают в одной Docker-сети, обращаются друг к другу по именам сервисов (postgres, eureka, auth).

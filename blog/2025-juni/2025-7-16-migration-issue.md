---
slug: laravel-migration-issue
title: Laravel Migration Issue
authors: faiz_maulana_habibi
tags: [laravel, programming]
---

## Laravel Migration

![Migration issue](./img/migration-db-issue.png)

<!-- truncate -->

You forgot setting your database and migrate it, basically laravel will use sqlite by default. So, if you change the database you need to migrate it.

```sh
php artisan migrate
```
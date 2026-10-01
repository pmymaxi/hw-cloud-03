# HW Cloud 03 — Terraform / Yandex Cloud

## Описание

В рамках работы была создана и настроена инфраструктура в Yandex Cloud с использованием Terraform.

В проекте реализованы:

- Object Storage;
- сервисный аккаунт и статический ключ доступа;
- шифрование Object Storage с использованием Yandex KMS;
- загрузка объекта в Object Storage;
- статический сайт в Object Storage;
- HTTPS-сертификат Let's Encrypt через Yandex Certificate Manager;
- публичная DNS-зона Yandex Cloud DNS;
- ANAME-запись для статического сайта;
- CNAME-запись для DNS challenge сертификата;
- доступ к сайту по собственному домену `https://nodnix.tech`.

## Object Storage

Создан bucket:

```text
hw-cloud-02-test-20260929
```

Для bucket:

- включено версионирование;
- настроено шифрование с использованием Yandex KMS;
- создан и настроен сервисный аккаунт;
- загружен объект `img/picture.jpg`.

Отдельно создан bucket для статического сайта:

```text
nodnix.tech
```

## Статический сайт

В bucket `nodnix.tech` настроен Static Website Hosting.

Используются страницы:

```text
index.html
error.html
```

Файлы загружаются Terraform из каталога `templates/`.

Для сайта настроен HTTPS через Yandex Certificate Manager.

Сертификат Let's Encrypt выпущен для:

```text
nodnix.tech
```

Сайт доступен по адресу:

```text
https://nodnix.tech
```

## DNS

Для домена создана отдельная публичная DNS-зона Yandex Cloud DNS.

DNS управляется отдельным Terraform-модулем:

```text
modules/dns/
```

Для сайта используется запись:

```text
nodnix.tech.
    ANAME
    nodnix.tech.website.yandexcloud.net.
```

Для Certificate Manager используется DNS challenge:

```text
_acme-challenge.nodnix.tech.
    CNAME
    <certificate-challenge>.cm.yandexcloud.net.
```

DNS-зона делегирована на Yandex Cloud DNS:

```text
ns1.yandexcloud.net
ns2.yandexcloud.net
```

## Terraform-модули

### `modules/storage/`

Управляет:

- Object Storage;
- сервисными аккаунтами;
- статическими ключами доступа;
- KMS;
- объектами bucket.

### `modules/website/`

Управляет сертификатом Yandex Certificate Manager.

### `modules/dns/`

Управляет публичной DNS-зоной и DNS-записями.

Также в проекте используются модули:

```text
modules/vpc/
modules/instance-group/
modules/load-balancer/
```

## Результат

В результате создан статический сайт в Yandex Object Storage с собственным доменным именем и HTTPS:

```text
https://nodnix.tech
```

DNS, сертификат, bucket и содержимое сайта управляются Terraform.

<img width="982" height="1716" alt="1" src="https://github.com/user-attachments/assets/ac0a75de-354a-483d-8a59-6d4a23e54855" />

<img width="1582" height="843" alt="2" src="https://github.com/user-attachments/assets/a755e367-a25d-4b71-9a13-aa363b9b33f4" />




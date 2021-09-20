FROM browsers/base:7.3

ARG VERSION=21.8.0.1967-1

RUN curl -s https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG | apt-key add - \
    && echo 'deb [arch=amd64] http://repo.yandex.ru/yandex-browser/deb beta main' > /etc/apt/sources.list.d/yandex-browser.list \
    && apt-get update && apt-get -y --no-install-recommends install yandex-browser-beta=$VERSION \
    && yandex-browser-beta --version \
    && rm /etc/apt/sources.list.d/yandex-browser.list \
    && rm -Rf /tmp/* && rm -Rf /var/lib/apt/lists/*

COPY yandexdriver /usr/bin/
COPY entrypoint.sh /

RUN chmod +x /usr/bin/yandexdriver
USER selenium

EXPOSE 4444
ENTRYPOINT ["/entrypoint.sh"]
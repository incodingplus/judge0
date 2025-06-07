FROM incodingplus/compilers:bookworm AS production

# ENV JUDGE0_HOMEPAGE "https://judge0.com"
LABEL homepage=""

ENV JUDGE0_SOURCE_CODE="https://github.com/incodingplus/judge0"
LABEL source_code=$JUDGE0_SOURCE_CODE

ENV JUDGE0_MAINTAINER="Han Kyeol Kim <myrlagksruf@gmail.com>"
LABEL maintainer=$JUDGE0_MAINTAINER

ENV PATH="/usr/local/rvm/rubies/ruby-2.7.8/bin:/opt/.gem/bin:$PATH"
ENV GEM_HOME="/opt/.gem/"

RUN apt-get update && \
    apt-get install -y \
      cron \
      libpq-dev \
      sudo && \
    rm -rf /var/lib/apt/lists/* && \
    echo "gem: --no-document" > /root/.gemrc && \
    gem install bundler:2.1.4 && \
    npm install -g --unsafe-perm aglio@2.3.0

EXPOSE 2358

WORKDIR /api

COPY Gemfile* ./
RUN RAILS_ENV=production bundle

COPY cron /etc/cron.d
RUN cat /etc/cron.d/* | crontab -

COPY . .

ENTRYPOINT ["/api/docker-entrypoint.sh"]
CMD ["/api/scripts/server"]

RUN useradd -u 1000 -m -r judge0 && \
    echo "judge0 ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers && \
    chown judge0: /api/tmp/

USER judge0

ENV JUDGE0_VERSION="1.0.3"
LABEL version=$JUDGE0_VERSION


FROM production AS development

CMD ["sleep", "infinity"]

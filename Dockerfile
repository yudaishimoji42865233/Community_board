FROM ruby:2.5.1

# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get update -qq
RUN apt-get install -y build-essential 
RUN apt-get install -y libpq-dev
RUN apt-get install -y nodejs

# ワーキングディレクトリの設定
RUN mkdir /community_board
WORKDIR /community_board

# gemfileを追加する
ADD Gemfile /community_board/Gemfile
ADD Gemfile.lock /community_board/Gemfile.lock

# gemfileのinstall
RUN bundle install
ADD . /community_board
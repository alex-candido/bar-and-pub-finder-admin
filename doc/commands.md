devise:
    rails generate devise:install
    rails generate devise User
    rails generate devise:views

pundit:
    rails generate pundit:install

tailwind:
    ./bin/rails css:install:tailwind
    ./bin/rails css:install:postcss

rails-credentials
    rm config/credentials.yml.enc config/master.key
    bin/rails credentials:edit

    EDITOR=nano bin/rails credentials:edit
    rails secret
    ex:
        secret_key_base: 2915043d0a68256dc39b28df9033b8cf0be33dff6773674ac767617afa4b>
        jwt_secret: d19afa4e86eb6481f12f8fc77e964ea651a6bf2618aa4d4ddc6cd6b8b3206de69>



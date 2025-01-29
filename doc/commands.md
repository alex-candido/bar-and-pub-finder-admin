devise:
    rails generate devise:install
    rails generate devise User
    rails generate devise:views

user:
    rails g migration AddColumnsToUsers name:string username:string info:json preferences:jsonb role:integer status:integer
    rails g scaffold_controller Admin::Users name:string username:string email:string info:json preferences:json role:integer status:integer --template-engine=slim

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
        secret_key_base: d7e4a2453f07738672243283761f0b119f7d8d5f983b3dab80aec81aaac5f1697a0803da9c4a02b7896efcdee16dc0751f57347a471143e33b5c8e82de1264c0
        jwt_secret: f1891900cab8ac3b6291076e52c4eb80d5785c6d99e6ab084c5e21a7f563c0cac97d4e62b7f9ecf7fd2559cf177e90cfddd7e4320f9f44b3a5336f0c1d9bb7d4



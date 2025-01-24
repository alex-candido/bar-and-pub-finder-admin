models:

rails g model Place name:string description:text info:jsonb latitude:float longitude:float coords:point type:integer status:integer

scaffold_controller:

rails g scaffold_controller Admin::Place name:string description:text latitude:float longitude:float status:integer type:integer info:jsonb coords:geography

postgres:

psql -h 0.0.0.0 -p 5434 -U barpub_finder 

rails console:

Place.g_near(Geo.point(-3.73737080508742, -38.5694092512131), 5).count
Place.near([-3.73737080508742, -38.5694092512131], 5).count(:all)
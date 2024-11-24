PL/SQL Developer Test script 3.0
10
begin
  -- Name must be provided
  adoption_pck.add_pet(p_pet_name => :p_pet_name,
                       p_species  => :p_species,
                       p_color    => :p_color,
                       p_breed    => :p_breed,
                       p_age      => :p_age,
                       p_weight   => :p_weight,
                       p_notes    => :p_notes);
end;
7
p_pet_name
1
Cooper
5
p_species
1
Dog
5
p_color
1
Golden Brown
5
p_breed
1
Golden Retriever
5
p_age
1
1
3
p_weight
1
25
4
p_notes
1
Friendly
5
0

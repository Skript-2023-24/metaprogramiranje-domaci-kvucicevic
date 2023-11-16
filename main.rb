# frozen_string_literal: true
require 'C:\Users\kajav\RubymineProjects\ruby-domaci-katarinavucicevic\metaprogramiranje-domaci-kvucicevic\table.rb'

table1 = Table.new('metaprogramiranje-domaci-kvucicevic/primer.xlsx')

# prints table
p table1.print_table

# Moguće je pristupati redu preko t.row(1), i pristup njegovim elementima po sintaksi niza.
p 'row 1 is: '
p table1.get_row(3)

# Biblioteka treba da vodi računa o merge-ovanim poljima   What does this mean?

p 'kolone'
p table1.initialize_cols

# Biblioteka vraća celu kolonu kada se napravi upit t[“Prva Kolona”]
p 'ime'
# p table1.get_col_by_name('Prva kolona')
p table1['prvakolona']

# Biblioteka omogućava pristup vrednostima unutar kolone po sledećoj sintaksi t[“Prva  Kolona”][1] za pristup drugom elementu te kolone
p table1['prvakolona'][1]

# Biblioteka omogućava podešavanje vrednosti unutar ćelije po sledećoj sintaksi t[“Prva Kolona”][1]= 2556
#table1['Prva Kolona'][1] = 2556
p 'setovana nova vrednost'
p table1['drugakolona'][1]

# Drugi deo, sumiranje i nov pristup koloni
p 'suma prve kolone: '
p table1.prvakolona.sum
# p table1.prvakolona.average #ideje nemam zasto ne radi

p 'getting cell by value'
value = 1
p table1.prvakolona.value # ostalo mi je jos ovo ii. kao i iii.

require 'securerandom'
require 'colorize'
require 'artii'
gem 'colorize'

def generar_contrasena(longitud, letras = true, numeros = true, simbolos = true)
  caracteres = ''
  caracteres += 'abcdefghijklmnopqrstuvwxyz' if letras
  caracteres += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' if letras
  caracteres += '0123456789' if numeros
  caracteres += '!@#$%^&*()_+-=' if simbolos
  SecureRandom.random_bytes(longitud).each_char.map do |char|
    caracteres.bytes.include?(char.ord) ? char : caracteres[char.ord % caracteres.length]
  end.join
end

def save_password(nombre, password)
  File.open("passwords.txt", "a") do |file|
    file.puts("#{nombre}: #{password}")
  end
end

def print_progress_bar(percent)
  bar_width = 50
  completed = percent * bar_width / 100
  remaining = bar_width - completed
  percent_color = percent >= 50 ? :green : :yellow
  print "Progreso: ["
  print "=" * completed
  print ">"
  print " " * remaining
  print "] #{percent}%\n".colorize(percent_color)
  sleep(0.3)
end


ascii = <<~EOS

███▄ ▄███▓▓█████  ██▓ ██▓███  
▓██▒▀█▀ ██▒▓█   ▀ ▓██▒▓██░  ██▒
▓██    ▓██░▒███   ▒██▒▓██░ ██▓▒
▒██    ▒██ ▒▓█  ▄ ░██░▒██▄█▓▒ ▒
▒██▒   ░██▒░▒████▒░██░▒██▒ ░  ░
░ ▒░   ░  ░░░ ▒░ ░░▓  ▒▓▒░ ░  ░
░  ░      ░ ░ ░  ░ ▒ ░░▒ ░     
░      ░      ░    ▒ ░░░       
       ░      ░  ░ ░           
                               
EOS
puts ascii.colorize(:light_blue) + "\n" * 2

puts "¡Bienvenido/a al generador de contraseñas!".center(80).colorize(:light_blue)
puts "Este programa te guiará a través del proceso de creación y guardado de contraseñas seguras.\n\n".center(80)

puts "¿Qué te gustaría hacer?\n".colorize(:red)
puts "1. Generar una contraseña".colorize(:light_blue)
puts "2. Salir".colorize(:light_blue)
print "Ingresa tu elección: ".colorize(:red)

eleccion = gets.chomp.to_i

if eleccion == 1
  puts "\n¡Genial! Comencemos...".center(80).colorize(:light_blue)
  sleep(0.5)

  print '¿Cómo te llamas? '.colorize(:red)
  name = gets.chomp
  sleep(0.5)

  puts "\nHola #{name}! Soy Meii, tu asistente de contraseñas.\n\n"
  sleep(0.5)

  print 'Ingresa la longitud de la contraseña que deseas generar: '.colorize(:red)
  longitud = gets.chomp.to_i
  sleep(0.5)

  print '¿Incluir letras? (s/n): '.colorize(:red)
  letras = gets.chomp.downcase == 's'
  print '¿Incluir números? (s/n): '.colorize(:red)
  numeros = gets.chomp.downcase == 's'
  print '¿Incluir símbolos? (s/n): '.colorize(:red)
  simbolos = gets.chomp.downcase == 's'
  sleep(0.5)

  puts "\nGenerando contraseña...\n\n"
  sleep(0.5)
  print_progress_bar(0)
  10.times do |i|
    print_progress_bar((i + 1) * 10)
  end

  password = generar_contrasena(longitud, letras, numeros, simbolos)

  puts "\n\nTu nueva contraseña es:".colorize(:light_blue)
  puts password.colorize(:yellow)

  puts "\n"
  print '¿Quieres darle un nombre a la contraseña? (s/n): '.colorize(:red)
  respuesta = gets.chomp.downcase
  if respuesta == 's'
    print 'Ingresa el nombre de la contraseña: '.colorize(:red)
    nombre = gets.chomp
  else
    nombre = 'Contraseña sin nombre'
  end

  puts "\n#{'-'*50}".colorize(:light_blue)
  puts "Nombre de la contraseña: #{nombre}".colorize(:light_blue)
  puts "Contraseña: #{password}".colorize(:yellow)
  puts "#{'-'*50}\n".colorize(:light_blue)

  save_password(nombre, password)

  puts "La he guardado en passwords.txt\n\n".colorize(:light_blue)
end
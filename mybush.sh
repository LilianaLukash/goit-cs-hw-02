#!/bin/bash

# Масив з URL вебсайтів для перевірки
websites=(
  "https://google.com"
  "https://facebook.com"
  "https://twitter.com"
)

# Назва файлу логів
log_file="website_status.log"

# Очищення файлу логів перед записом нових результатів
> "$log_file"

# Перевірка кожного сайту зі списку
for website in "${websites[@]}"; do
  # Використання curl для надсилання HTTP GET запиту і отримання HTTP статус-коду
  http_status=$(curl -o /dev/null -s -w "%{http_code}\n" -L "$website")

  # Перевірка, чи статус-код дорівнює 200
  if [ "$http_status" -eq 200 ]; then
    echo "<$website> is UP" | tee -a "$log_file"
  else
    echo "<$website> is DOWN" | tee -a "$log_file"
  fi
done
# Виведення повідомлення про завершення перевірки
echo "Результати записано у файл логів: $log_file"

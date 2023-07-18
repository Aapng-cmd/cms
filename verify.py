#!/usr/bin/python

import sys
import smtplib, mimetypes
from random import randint as ri
from email.mime.multipart import MIMEMultipart # Многокомпонентный объект
from email.mime.text import MIMEText # Текст/HTML

dest_email = sys.argv[1]
sa = sys.argv[2]

msg_txt = "http://127.0.0.1/cms/reg.php?q=" + sa + "&email=" + dest_email

def send_email(addr_to, f1le=0, msg_subj="Test", msg_text="hello"):
    msg = MIMEMultipart()
    addr_from = "" # Отправитель
    password = "" # Пароль

# msg = MIMEMultipart() # Создаем сообщение
    msg['From'] = addr_from # Адресат
    msg['To'] = addr_to # Получатель
    msg['Subject'] = msg_subj # Тема сообщения

    body = msg_text # Текст сообщения
    msg.attach(MIMEText(body, 'plain')) # Добавляем в сообщение текст

# process_attachement(msg, files)

# ======== Этот блок настраивается для каждого почтового провайдера отдельно ===============================================
    server = smtplib.SMTP_SSL('smtp.mail.ru') # Создаем объект SMTP
    # server.starttls() # Начинаем шифрованный обмен по TLS
    # server.set_debuglevel(True) # Включаем режим отладки, если не нужен - можно закомментировать
    server.login(addr_from, password) # Получаем доступ
    server.send_message(msg, from_addr=addr_from, to_addrs=addr_to) # Отправляем сообщение
    server.quit() # Выходим
# ==========================================================================================================================


send_email(dest_email, msg_text=msg_txt)
print(sa)

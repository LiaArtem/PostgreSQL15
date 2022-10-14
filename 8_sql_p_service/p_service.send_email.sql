CREATE OR REPLACE FUNCTION p_service.send_email(_from text, _password text, smtp text, port integer, bcc text, receiver text, subject text, send_message text)
 RETURNS text
 LANGUAGE plpython3u
AS $function$
# -------------------------------------------------------
# �������� ��������� ����� ������� � ���� ������
# _from - ����� � e-mail ������������
# _password - ������ ������������
# smtp - ����� ��������� ������� smtp
# port - ���� ��������� ������� smtp
# bcc - e-mail ���������� (������� �����)
# receiver - e-mail ����������
# subject - ���� ������
# send_message - ����� ������
# -------------------------------------------------------
import smtplib
from smtplib import SMTPException
message = ("From: %snTo: %snBcc: %snMIME-Version: 1.0nContent-type: text/htmlnSubject: %snn %s" % (_from,receiver,bcc,subject,send_message))
try:
  smtpObj = smtplib.SMTP(smtp,port)
  smtpObj.starttls()
  smtpObj.login(_from, _password)
  smtpObj.sendmail(_from,receiver,message.encode('utf-8'))
  print ('Successfully sent email')
except SMTPException:
  print ('Error: unable to send email')
return message
$function$
;

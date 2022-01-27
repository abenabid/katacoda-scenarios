rm -rf .*

cat > lettre.txt <<EOF
Bob,

Ceci est une lettre confidentielle


De tout temps, l'homme tente de comprendre puis de reproduire l'extraordinaire machine qu'est l'humain. 
Les premiers automates nous font sourire aujourd'hui. 
Les premiers ordinateurs le font aussi, mais un peu moins. 
Et lorsqu'un certain McCullogn invente en 1943 le premier neurone formel, on ne rigole plus. 
L'ordinateur est devenu capable de reproduire des neurones artificiels. 
Le "complexe de Frankenstein" va alors freiner les recherches. 
On entend parler du concept d'Intelligence Artificielle, plus connu sous les termes d'IA. 
Cela fait peur.

Alice.
EOF

cat > symetrique.py <<'EOF'
# Inspired from https://pythonprogramming.net/encryption-and-decryption-in-python-code-example-with-explanation/
# PyCrypto docs available at https://www.dlitz.net/software/pycrypto/api/2.6/
# Made interactive by Hillstone

from Crypto.Cipher import AES
import base64, os, sys, binascii
from pathlib import Path

def generate_secret_key_for_AES_cipher():
	# AES key length must be either 16, 24, or 32 bytes long
	AES_key_length = 16 # use larger value in production
	# generate a random secret key with the decided key length
	# this secret key will be used to create AES cipher for encryption/decryption
	secret_key = os.urandom(AES_key_length)
	# encode this secret key for storing safely in database
	encoded_secret_key = base64.b64encode(secret_key)
	return encoded_secret_key

def encrypt_message(private_msg, encoded_secret_key, padding_character):
	# decode the encoded secret key
	secret_key = base64.b64decode(encoded_secret_key)
	# use the decoded secret key to create a AES cipher
	cipher = AES.new(secret_key)
	# pad the private_msg
	# because AES encryption requires the length of the msg to be a multiple of 16
	padded_private_msg = private_msg + (padding_character * ((16-len(private_msg)) % 16))
	# use the cipher to encrypt the padded message
	encrypted_msg = cipher.encrypt(padded_private_msg)
	# encode the encrypted msg for storing safely in the database
	encoded_encrypted_msg = base64.b64encode(encrypted_msg)
	# return encoded encrypted message
	return encoded_encrypted_msg

def decrypt_message(encoded_encrypted_msg, encoded_secret_key, padding_character):
	# decode the encoded encrypted message and encoded secret key
	secret_key = base64.b64decode(encoded_secret_key)
	encrypted_msg = base64.b64decode(encoded_encrypted_msg)
	# use the decoded secret key to create a AES cipher
	cipher = AES.new(secret_key)
	# use the cipher to decrypt the encrypted message
	decrypted_msg = cipher.decrypt(encrypted_msg)
	# unpad the encrypted message
	unpadded_private_msg = decrypted_msg.rstrip(bytes(padding_character, "utf8"))
	# return a decrypted original private message
	return unpadded_private_msg

def encrypt_file(file, key):
	new_file = file + ".encrypted"
	print("Chiffrement en cours...")

	with open(file) as f:
		contents = f.read()
	
	encrypted_contents = encrypt_message(contents, key, '#')

	with open(new_file, 'w') as f:
		f.write( encrypted_contents.decode("utf-8") )

	print("Fin du chiffrement")
	print("Vous trouvez le resultat dans le fichier " + new_file)

def decrypt_file(file, key):
	new_file = file + ".decrypted"
	print("Dechiffrement en cours...")

	with open(file) as f:
		contents = f.read()
	
	decrypted_contents = decrypt_message(contents, key, '#')

	with open(new_file, 'w') as f:
		f.write( decrypted_contents.decode("utf-8") )


	print("Fin du dechiffrement")
	print("Vous trouvez le resultat dans le fichier " + new_file)

def valid_key(key):
	try:
		decoded = base64.b64decode(key, validate=True)
	except binascii.Error:
		print('base64')
		return False

	if len(decoded) == 16:
		return True
	else:
		print('len')
		return False

def help():
	print("Action possibles:")
	print("keygen:  Genere une cle secrete")
	print("encrypt: Chiffre un fichier a l'aide d'une cle secrete")
	print("decrypt: Dechiffrer un fichier a l'aide d'une cle secrete")
	print()
	print("Exemples:")
	print("python symetrique.py keygen")
	print("python symetrique.py encrypt <FICHIER>")
	print("python symetrique.py decrypt <FICHIER>")

####### BEGIN HERE #######

if len(sys.argv) == 1 or (len(sys.argv) == 2 and sys.argv[1] != "keygen") or (len(sys.argv) == 3 and sys.argv[1] not in ["encrypt", "decrypt"]):
	help()
	sys.exit()

if sys.argv[1] == "keygen":
	secret_key = generate_secret_key_for_AES_cipher()
	print("\n   Voici votre cle secrete:\n")
	print("   " + secret_key.decode("utf-8") + "\n" )
	print("   Ne la perdez pas !\n")
	Path('/tmp/obj1').touch()

if sys.argv[1] in ["encrypt", "decrypt"]:
	file = sys.argv[2]
	if not os.path.isfile(file):
		print("Fichier inexistant: " + file)
		sys.exit()

	key = input("Entrez votre cle secrete: ")

	if not valid_key(key):
		print("Format de la cle invalide")
		sys.exit()

	if sys.argv[1] == "encrypt":
		encrypt_file(file, key)
	else:
		decrypt_file(file, key)
EOF

pip install pycrypto
rm -rf .*
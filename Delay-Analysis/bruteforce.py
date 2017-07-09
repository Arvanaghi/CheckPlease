#!/usr/bin/env python3

# AES encrypts code using a constrained keyspace
# Source code brute forces itself at runtime to find
# the key and run the original code

import argparse
import base64
import random
import string
import sys
from Crypto.Cipher import AES

def constrained_aes(plaintext_data):
    """
    Generates a constrained AES key which is later brute forced
    in a loop
    """
    # Create our constrained Key
    small_key = randomKey(25)

    # Actual Key used
    real_key = small_key + str(randomNumbers())

    # Create Cipher Object with Generated Secret Key
    aes_cipher_object = AES.new(real_key, AES.MODE_ECB)

    # Prep for manipulation (this is really for python stallion only)
    # If this function as a whole is needed for another language
    # It should probably be rewritten without this step
    plaintext_data = plaintext_data.encode('latin-1')
    plaintext_data = plaintext_data.decode('unicode_escape')

    # Pad the shellcode
    padded_shellcode = encryption_padding(plaintext_data, '*')

    # actually encrypt the shellcode
    encrypted_shellcode = aes_cipher_object.encrypt(padded_shellcode)

    # Base64 encode the encrypted shellcode
    encoded_ciphertext = base64.b64encode(encrypted_shellcode)

    # return a tuple of (encodedText, small constrained key, actual key used)
    return encoded_ciphertext, small_key, real_key

def create_cli_parser():
    parser = argparse.ArgumentParser(
        add_help=False, description="BruteForcer encrypts code with a constrained\
        key resulting in code brute forcing itself at runtime.")
    parser.add_argument('-h', '-?', '--h', '-help',
                        '--help', action="store_true", help=argparse.SUPPRESS)

    protocols = parser.add_argument_group('Options')
    protocols.add_argument('-f', '--file', metavar='Filename', default=None,
                           help='File containing data to encrypt')
    protocols.add_argument('-py', '--python', default=False, action='store_true',
                           help='Encrypting python code')

    args = parser.parse_args()

    if args.h:
        parser.print_help()
        sys.exit()

    if args.file is None:
        print('Error: You need to provide a file containing code to encrypt! Try again')
        sys.exit(1)

    if not args.python:
        print('You need to provide a language to encrypt! Try again...')
        sys.exit(1)

    return args

def encryption_padding(data_to_pad, padding_letter=4):
    if padding_letter == 4:
        padding_letter = random.choice(string.ascii_letters + string.digits + "{}!@#$^&()*&[]|,./?")
    while len(data_to_pad) % 16 != 0:
        data_to_pad += padding_letter.encode()
    return data_to_pad

# Taken from Veil code
def randomKey(b=32):
    """
    Returns a random string/key of "b" characters in length, defaults to 32
    """
    return ''.join(random.choice(string.ascii_letters + string.digits + "{}!@#$^&()*&[]|,./?") for x in range(b))

def randomNumbers(b=7):
    """
    Returns a random string/key of "b" characters in length, defaults to 7
    """
    random_number = int(''.join(random.choice(string.digits) for x in range(b))) + 100000

    if random_number < 1000000:
        random_number = random_number + 1000000

    return random_number

def randomString(length=-1):
    """
    Returns a random string of "length" characters.
    If no length is specified, resulting string is in between 6 and 15 characters.
    """
    if length == -1:
        length = random.randrange(6, 16)
    random_string = ''.join(random.choice(string.ascii_letters) for x in range(length))
    return random_string

# let's start making code

if __name__ == '__main__':

    # Parse cli stuff
    arguments = create_cli_parser()

    # Grab a constrained random key and IV for encrypting stuff
    aes_base_key = randomKey(25)
    constrained_key = aes_base_key + str(randomNumbers())

    # Create the encryption object
    cipher_object = AES.new(constrained_key, AES.MODE_ECB)

    # read in source code to encrypt
    with open(arguments.file, 'rb') as incoming_data:
        encrypt_me = incoming_data.read()

    # pad the source code (data should be in byte format)
    padded_data = encryption_padding(encrypt_me, '&')

    # encrypt the padded souce code
    encrypted_data = cipher_object.encrypt(padded_data)

    # base64 encode the data
    encoded_ciphertext = base64.b64encode(encrypted_data)

    # begin creating final output code and add encoded_ciphertext to it
    final_code = '#!/usr/bin/env python3\n'
    final_code += 'import base64\n'
    final_code += 'from Crypto.Cipher import AES\n'
    final_code += 'encoded_ct = "' + encoded_ciphertext.decode('ascii') + '"\n'
    final_code += 'decoded = base64.b64decode(encoded_ct)\n'
    final_code += 'for second_half in range(1000000, 10000000):\n'
    final_code += '\tkey = "' + aes_base_key + '"\n'
    final_code += '\tkey = key + str(second_half)\n'
    final_code += '\tc_o = AES.new(key, AES.MODE_ECB)\n'
    final_code += '\tdecrypted = c_o.decrypt(decoded)\n'
    final_code += '\ttry:\n'
    final_code += '\t\tdecrypted = decrypted.decode("ascii")\n'
    final_code += '\t\tdecrypted = decrypted.rstrip("&")\n'
    final_code += '\t\texec(decrypted)\n'
    final_code += '\texcept:\n'
    final_code += '\t\tpass'

    print('[*] Writing encrypted file to disk.')
    print('[*] Key used: ' + constrained_key)

    # write out code to disk
    with open('encrypted_code.py', 'w') as code_out:
        code_out.write(final_code)

    #fin

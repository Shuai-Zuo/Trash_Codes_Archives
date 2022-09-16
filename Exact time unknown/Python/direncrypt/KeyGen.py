import random
import time
import string
 
def random_string_generator(str_size, allowed_chars):
    return ''.join(random.choice(allowed_chars) for x in range(str_size))


def GenerateKey(size = 32):
    chars = string.ascii_letters + string.digits
    size
    return random_string_generator(size, chars)
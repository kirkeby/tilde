#!/usr/bin/env python

# Defang awful horrible Shit/MIME messages.

import io
import os
import mimetools
import socket
import subprocess
import sys
import time

key_file = os.path.expanduser('~/.smime/keys/9ad2c83b.0')
backup_folder = os.path.expanduser('~/work/Mails-before-smime-decrypt')
# Icky, but required.
__defang_counter = [0]


def main():
    errors = False
    for filename in sys.argv[1:]:
        if not os.path.exists(filename):
            # Assume it's a silently failed shell-glob.
            continue
        try:
            defang_smime(filename)
        except Exception:
            print 'Failed to S/MIME-defang %s, leaving in-place' % filename
            errors = True

    if errors:
        sys.exit(1)


# Because ofcourse
smime_types = set([
    'application/pkcs7-mime',
    'application/x-pkcs7-mime',
])

def defang_smime(path):
    msg = mimetools.Message(open(path, 'rb'))
    if msg.gettype() not in smime_types:
        return
    if msg.getparam('smime-type') != 'enveloped-data':
        return

    if not os.path.exists(backup_folder):
        os.makedirs(backup_folder)
    backup_path = os.path.join(backup_folder, os.path.basename(path))
    assert not os.path.exists(backup_path)

    tmppath = os.path.join(
        os.path.dirname(os.path.dirname(path)),
        'tmp',
        os.path.basename(path))
    with open(tmppath, 'wb') as f:
        # This is the hackiest, bestest code I've ever written!
        for hdr in msg.headers:
            if hdr.lower().startswith('content-'):
                continue
            f.write(hdr)
        f.flush()
        subprocess.check_call(
            'openssl cms -decrypt -inkey {} -in {} >> {}'.format(
                key_file, path, tmppath,
            ),
            shell=True,
        )

    # Generate a new path for the changed mail, so mbsync knows it has not
    # seen it before.
    new_name = '{}.{}_{}.{}'.format(
        int(time.time()),
        os.getpid(),
        __defang_counter[0],
        socket.gethostname(),
    )
    __defang_counter[0] += 1
    new_path = os.path.join(os.path.dirname(path), new_name)

    os.rename(path, backup_path)
    os.rename(tmppath, new_path)

    print 'Successfully S/MIME-defanged %s -> %s' % (path, new_path)


if __name__ == '__main__':
    main()

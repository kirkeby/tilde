# Defang awful horrible Shit/MIME messages.

import io
import os
import rfc822
import subprocess
import sys

key_file = os.path.expanduser('~/.smime/keys/9ad2c83b.0')
backup_folder = os.path.expanduser('~/work/Mails-before-smime-decrypt')


def main():
    for filename in sys.argv[1:]:
        defang_smime(filename)


def defang_smime(path):
    msg = rfc822.Message(open(path, 'rb'))
    content_type = msg.getheader('Content-Type', '')
    content_type = content_type.split(';')[0]
    if content_type != 'application/pkcs7-mime':
        return

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

    os.rename(path, backup_path)
    os.rename(tmppath, path)


if __name__ == '__main__':
    main()

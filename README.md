### drone-decrypt-files

![](https://img.shields.io/docker/pulls/msfjarvis/drone-decrypt-files.svg)

Small Drone CI plugin to decrypt AES 256-bit encrypted files. Useful to store blobbed secrets in the
repo.

## Configuration

An example configuration will look like this.

```yaml
  - name: export-keys
    image: msfjarvis/drone-decrypt-files:latest
    settings:
      file_to_path_mapping:
        - 'ci/keystore.cipher:keystore.jks|ci/props.cipher:keystore.properties'
      decrypt_key:
        from_secret: key
```

What does this do:
- Use the secret `key` to decrypt files
- Decrypt `ci/keystore.cipher` to `keystore.jks` and `ci/props.cipher` to `keystore.properties`

## Preparation

This image is configured to use the `aes-256-cbc` cipher from `openssl` to decrypt files, so that's
what you'll need to encrypt them with as well.

Use `openssl enc -aes-256-cbc -md sha256 -pbkdf2 -salt -in secrets.txt -out secrets.txt.enc` to encrypt the secrets, add them
to your repo then set `file_to_path_mapping` in this format: `encrypted_file_1:decrypted_file_1|encrypted_file_2:decrypted_file_2`.

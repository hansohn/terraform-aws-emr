{
  "EncryptionConfiguration": {
    "EnableInTransitEncryption": ${EnableInTransitEncryption},
    "EnableAtRestEncryption": ${EnableAtRestEncryption},
    "AtRestEncryptionConfiguration": {
      "S3EncryptionConfiguration": {
        "EncryptionMode": "${AtRestS3EncryptionMode}"
      }
    }
  }
}

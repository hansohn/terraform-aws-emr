{
  "source": [
    "aws.emr"
  ],
  "detail-type": [
    "EMR Auto Scaling Policy State Change",
    "EMR Step Status Change",
    "EMR Cluster State Change",
    "EMR Instance Group State Change",
    "EMR Instance Fleet State Change",
    "EMR Instance Group Status Notification"
  ],
  "detail": {
    "clusterId": [
      "${emr_cluster_id}"
    ]
  }
}

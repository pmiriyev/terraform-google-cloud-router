/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.0"

  project_id   = var.project_id
  network_name = "test-network"
  routing_mode = "GLOBAL"
  subnets      = []
}


# [START cloudrouter_create]
module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 6.0"

  name   = "my-router"
  region = "us-central1"

  bgp = {
    # The ASN (16550, 64512 - 65534, 4200000000 - 4294967294) can be any private ASN
    # not already used as a peer ASN in the same region and network or 16550 for Partner Interconnect.
    asn = "65001"
  }

  project = var.project_id
  network = module.vpc.network_name
}
# [END cloudrouter_create]

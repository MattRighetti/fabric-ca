# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# -------------------------------------------------------------
# This makefile defines the following targets
#
#   - all (default) - builds all targets and runs all tests
#   - license - check all go files for license headers
#   - cop - builds the cop executable
#   - tests - runs all the cop tests
#   - unit-tests - runs the go-test based unit tests

all: license cop tests unit-tests

license: .FORCE
	@scripts/license_check && exit

cop:
	@echo "Building cop in bin directory ..."
	@mkdir -p bin && cd cli/cop && go build -o ../../bin/cop
	@echo "Built bin/cop"

tests: cop unit-tests

unit-tests: cop
	@echo "Running cop unit tests ..."
	@go test `go list ./... | grep -v "/vendor/"`
	@echo "Completed cop unit tests"

.FORCE:

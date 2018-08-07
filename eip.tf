resource "aws_eip" "test-eip" {
  instance    = "${aws_instance.my-test-instance.id}"
}

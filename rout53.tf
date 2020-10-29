resource "aws_route53_record" "terraform" {
  zone_id = "${data.aws_route53_zone.sush-zone.zone_id}"
  name    = "terraform.${var.route53_hosted_zone_name}"
  type    = "A"
  alias {
    name                   = "${aws_alb.sush-alb.dns_name}"
    zone_id                = "${aws_alb.sush-alb.zone_id}"
    evaluate_target_health = true
  }
}

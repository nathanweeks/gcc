/* { dg-do compile } */
/* { dg-options "-Wcompare-distinct-pointer-types" } */

typedef int __u32;

struct xdp_md
{
  char *data;
  char *data_meta;
};

int xdp_context (struct xdp_md *xdp)
{
  void *data = (void *)(long)xdp->data;
  __u32 *metadata = (void *)(long)xdp->data_meta;
  __u32 ret;

  if (metadata + 1 > data) /* { dg-warning "comparison of distinct pointer types" } */
    return 1;
  if (metadata + 1 >= data) /* { dg-warning "comparison of distinct pointer types" } */
    return 2;
  if (metadata + 1 < data) /* { dg-warning "comparison of distinct pointer types" } */
    return 3;
  if (metadata + 1 <= data) /* { dg-warning "comparison of distinct pointer types" } */
    return 4;
  if (metadata + 1 == data) /* { dg-warning "comparison of distinct pointer types" } */
    return 5;
  if (metadata + 1 != data) /* { dg-warning "comparison of distinct pointer types" } */
    return 5;

  return 1;
}

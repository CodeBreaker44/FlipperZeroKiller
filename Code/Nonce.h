void xor_a_b(char *a, char *b)
{
    unsigned char i;
    for (i = 0; i < 4; i++)
    {
        a[i] = a[i] ^ b[i];
    }

}

void simplehash(char * msg)
{
  unsigned char i;
  for ( i = 1; i <= 4; i++)
  {
    xor_a_b(msg, msg + (4*i));
  }

}

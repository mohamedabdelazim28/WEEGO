"use client";

import NextLink from "next/link";
import { ComponentProps } from "react";

/**
 * Custom Link component that disables prefetching for static export.
 * Next.js tries to prefetch RSC payloads (__PAGE__.txt files) which don't exist
 * on static hosting (like Hostinger), causing 404 errors and browser hangs.
 */
export default function Link(props: ComponentProps<typeof NextLink>) {
  return <NextLink {...props} prefetch={false} />;
}

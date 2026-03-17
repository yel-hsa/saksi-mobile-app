import { ReactNode } from "react";
import { clsx } from "clsx";

export const Typography = {
  H1: ({ children, className }: { children: ReactNode; className?: string }) => (
    <h1 className={clsx("font-black text-2xl tracking-tight text-[#333333] leading-none", className)}>
      {children}
    </h1>
  ),
  H2: ({ children, className }: { children: ReactNode; className?: string }) => (
    <h2 className={clsx("font-black text-xl tracking-tight text-[#333333]", className)}>
      {children}
    </h2>
  ),
  H3: ({ children, className }: { children: ReactNode; className?: string }) => (
    <h3 className={clsx("font-black text-lg text-[#333333] leading-tight", className)}>
      {children}
    </h3>
  ),
  Subtitle: ({ children, className }: { children: ReactNode; className?: string }) => (
    <p className={clsx("text-[11px] font-bold text-gray-400 uppercase tracking-widest", className)}>
      {children}
    </p>
  ),
  Body: ({ children, className }: { children: ReactNode; className?: string }) => (
    <p className={clsx("text-sm font-medium text-gray-500 leading-relaxed", className)}>
      {children}
    </p>
  ),
  Caption: ({ children, className }: { children: ReactNode; className?: string }) => (
    <span className={clsx("text-xs font-semibold text-gray-400", className)}>
      {children}
    </span>
  ),
};

import { HTMLAttributes, forwardRef } from "react";
import { clsx } from "clsx";

export interface BadgeProps extends HTMLAttributes<HTMLSpanElement> {
  variant?: "success" | "warning" | "danger" | "info" | "neutral";
  size?: "sm" | "md";
}

export const Badge = forwardRef<HTMLSpanElement, BadgeProps>(
  ({ className, variant = "neutral", size = "md", children, ...props }, ref) => {
    const baseStyles = "inline-flex items-center font-bold uppercase tracking-wider border";
    
    const variants = {
      success: "bg-green-50 text-green-700 border-green-200",
      warning: "bg-amber-50 text-amber-700 border-amber-200",
      danger: "bg-red-50 text-[#D32F2F] border-red-200",
      info: "bg-blue-50 text-blue-700 border-blue-200",
      neutral: "bg-gray-100 text-gray-600 border-gray-200",
    };

    const sizes = {
      sm: "text-[10px] px-2 py-0.5 rounded-md gap-1",
      md: "text-[11px] px-2.5 py-1 rounded-lg gap-1.5",
    };

    return (
      <span
        ref={ref}
        className={clsx(baseStyles, variants[variant], sizes[size], className)}
        {...props}
      >
        {children}
      </span>
    );
  }
);
Badge.displayName = "Badge";

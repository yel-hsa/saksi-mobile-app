import { HTMLAttributes, forwardRef } from "react";
import { clsx } from "clsx";

export interface CardProps extends HTMLAttributes<HTMLDivElement> {
  padding?: "none" | "sm" | "md" | "lg";
  interactive?: boolean;
}

export const Card = forwardRef<HTMLDivElement, CardProps>(
  ({ className, padding = "md", interactive = false, children, ...props }, ref) => {
    const baseStyles = "bg-white rounded-[24px] shadow-[0_8px_30px_rgba(0,0,0,0.04)] border border-gray-100 overflow-hidden relative";
    
    const paddings = {
      none: "p-0",
      sm: "p-4",
      md: "p-6",
      lg: "p-8",
    };

    const interactiveStyles = interactive
      ? "cursor-pointer hover:shadow-md hover:border-gray-200 transition-all group"
      : "";

    return (
      <div
        ref={ref}
        className={clsx(baseStyles, paddings[padding], interactiveStyles, className)}
        {...props}
      >
        {children}
      </div>
    );
  }
);
Card.displayName = "Card";

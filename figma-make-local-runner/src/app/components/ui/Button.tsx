import { ButtonHTMLAttributes, forwardRef } from "react";
import { clsx } from "clsx";

export interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: "primary" | "secondary" | "outline" | "ghost";
  size?: "sm" | "md" | "lg";
  fullWidth?: boolean;
}

export const Button = forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant = "primary", size = "md", fullWidth = false, children, ...props }, ref) => {
    const baseStyles = "inline-flex items-center justify-center font-bold transition-all active:scale-[0.98] disabled:opacity-50 disabled:pointer-events-none";
    
    const variants = {
      primary: "bg-[#D32F2F] text-white shadow-[0_8px_20px_rgba(211,47,47,0.25)] hover:bg-red-700",
      secondary: "bg-[#333333] text-white shadow-md hover:bg-black",
      outline: "bg-white border-2 border-gray-200 text-[#333333] hover:bg-gray-50",
      ghost: "bg-transparent text-gray-600 hover:bg-gray-100",
    };

    const sizes = {
      sm: "text-xs py-2 px-4 rounded-lg gap-1.5",
      md: "text-[13px] py-3.5 px-6 rounded-xl gap-2",
      lg: "text-[15px] py-4 px-8 rounded-2xl gap-3",
    };

    return (
      <button
        ref={ref}
        className={clsx(
          baseStyles,
          variants[variant],
          sizes[size],
          fullWidth ? "w-full" : "",
          className
        )}
        {...props}
      >
        {children}
      </button>
    );
  }
);
Button.displayName = "Button";

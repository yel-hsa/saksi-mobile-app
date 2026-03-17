import { InputHTMLAttributes, forwardRef, ReactNode } from "react";
import { clsx } from "clsx";

export interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  leftIcon?: ReactNode;
  rightIcon?: ReactNode;
  error?: string;
}

export const Input = forwardRef<HTMLInputElement, InputProps>(
  ({ className, leftIcon, rightIcon, error, ...props }, ref) => {
    return (
      <div className="flex flex-col gap-1.5 w-full">
        <div className="relative flex items-center">
          {leftIcon && (
            <div className="absolute left-4 text-gray-400 pointer-events-none flex items-center justify-center">
              {leftIcon}
            </div>
          )}
          <input
            ref={ref}
            className={clsx(
              "w-full bg-white border-2 border-gray-200 rounded-2xl px-4 py-3.5 text-[15px] text-[#333333] font-medium placeholder-gray-400 transition-colors focus:outline-none focus:border-[#333333] focus:ring-0 disabled:bg-gray-50 disabled:text-gray-400 disabled:cursor-not-allowed",
              leftIcon && "pl-11",
              rightIcon && "pr-11",
              error && "border-[#D32F2F] focus:border-[#D32F2F] text-[#D32F2F]",
              className
            )}
            {...props}
          />
          {rightIcon && (
            <div className="absolute right-4 text-gray-400 flex items-center justify-center">
              {rightIcon}
            </div>
          )}
        </div>
        {error && <span className="text-xs font-bold text-[#D32F2F] pl-1">{error}</span>}
      </div>
    );
  }
);
Input.displayName = "Input";

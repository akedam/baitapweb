package com.app.filter;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // In SiteMesh 3, the default decorator directory is /WEB-INF/decorators/
        // Specifying "auth.jsp" resolves to /WEB-INF/decorators/auth.jsp
        builder.addDecoratorPath("/login", "auth.jsp")
               .addDecoratorPath("/register", "auth.jsp")
               .addDecoratorPath("/forgot-password", "auth.jsp")
               .addDecoratorPath("/verify-otp", "auth.jsp")
               .addDecoratorPath("/reset-password", "auth.jsp")
               .addDecoratorPath("/views/login.jsp", "auth.jsp")
               .addDecoratorPath("/views/register.jsp", "auth.jsp")
               .addDecoratorPath("/views/forgot-password.jsp", "auth.jsp")
               .addDecoratorPath("/views/verify-otp.jsp", "auth.jsp")
               .addDecoratorPath("/views/reset-password.jsp", "auth.jsp");

        // Main Web Decorator resolves to /WEB-INF/decorators/web.jsp
        builder.addDecoratorPath("/*", "web.jsp");

        // Exclude static resources and internal directories
        builder.addExcludedPath("/css/*")
               .addExcludedPath("/js/*")
               .addExcludedPath("/images/*")
               .addExcludedPath("/uploads/*")
               .addExcludedPath("/assets/*")
               .addExcludedPath("/WEB-INF/*");
    }
}

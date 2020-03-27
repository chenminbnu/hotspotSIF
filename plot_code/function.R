#########################################
## plot scatter plot and show R2, p values,  fittiong equation across different LC type
sa_plot_lue = function(data, label_x, label_y, lim_x, lim_y, max_color,legend_title){
 
  colnames(data) <- c("x","y","z")
  sa_plot_lue <- ggplot(data, mapping = aes(x = x, y = y, color = z)) + xlab(label_x) + ylab(label_y) +  #ggtitle(title_text) + 
    geom_point(size = 2.5) + 
    theme_bw() +
    theme(panel.border = element_rect(fill=NA, colour = "black", size=1),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.title = element_text(size = 18, face = "bold", color="black"), text = element_text(face = "bold", size=15, color="black"),  legend.text = element_text(size = 20, face = "bold", color="black"),
          legend.key.height = unit(1.5, "inch"), legend.key.width = unit(0.3, "inch")) + 
    scale_color_gradient(low = "blue", high = "red",limits = c(0, max_color)) + 
    guides(fill = guide_colourbar(ticks = FALSE))+
    coord_cartesian(ylim=c(0,lim_y),xlim = c(0, lim_x+0.001))+ scale_x_continuous(breaks=c(0.0,0.005,0.01),labels =c('0.0','0.005','0.01')) + 
  labs(color = legend_title) + 
    guides(fill = guide_colourbar(barwidth = 3, barheight = 27, ticks = FALSE))+ theme(plot.margin = unit(c(0, 0, 0, 0), "cm"))+ 
    theme(axis.text.x = element_text(face="bold", color="black",size=14, angle=0),
          axis.text.y = element_text(face="bold", color="black", size=14, angle=45),
          axis.title.x = element_text(face="bold", color="black",size=16),
          axis.title.y = element_text(face="bold", color="black",size=16),
          plot.margin = unit(c(0, 0, 0, 0.3), "cm"))
  
  
  #+
   # theme(title = element_text(size = 20, color = 'red', face = "bold"), aspect.ratio = 0.5)
  #       legend.title = element_text(size = 10, face = "bold"),
  #       legend.text = element_text(size = 10),
  #       legend.key.height = unit(1,'cm')) 
  
  
  return (sa_plot_lue)
}


#########################################
## plot scatter plot and show R2, p values,  fittiong equation across different LC type
sa_plot_other = function(data, label_x, label_y, lim_x, lim_y, title_text,legend_title){
  colnames(data) <- c("x","y","z")
  
  sa_plot_other <- ggplot(data, mapping = aes(x = x, y = y, color = z)) + xlab(label_x) + ylab(label_y ) + 
    geom_point(size = 2.5) + 
    theme_bw() +
    theme(
      panel.border = element_rect(fill=NA, colour = "black", size=1),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.title = element_text(size = 18, face = "bold", color="black"), text = element_text(size=15,face = "bold", color="black"), legend.text = element_text(size = 20, face = "bold", color="black"),
          legend.key.height = unit(1.5, "inch"), legend.key.width = unit(0.3, "inch"), axis.title.y = element_text(size = 15, face = "bold" , color="black")) + 
    scale_color_gradient(low = "blue", high = "red",limits = c(0, max_color)) + 
    guides(fill = guide_colourbar(ticks = FALSE))+
    coord_cartesian(ylim=c(0,lim_y),xlim = c(0, lim_x)) + 
    labs(color = legend_title) +
    guides(fill = guide_colourbar(barwidth = 3, barheight = 27, ticks = FALSE)) + theme(plot.margin = unit(c(0, 0, 0, 0), "cm"))+ 
    theme(axis.text.x = element_text(face="bold", color="black",size=14, angle=0),
          axis.text.y = element_text(face="bold", color="black", size=14, angle=45),
          axis.title.x = element_text(face="bold", color="black",size=16),
          axis.title.y = element_text(face="bold", color="black",size=16),
          plot.margin = unit(c(0, 0, 0, 0.3), "cm")) 
  
  
  
  return (sa_plot_other)
}




################3 LIDF
#########################################
## plot scatter plot and show R2, p values,  fittiong equation across different LC type
sa_plot_lue_lidf = function(data, label_x, label_y, lim_x, lim_y, max_color,legend_title){
  rhg_cols <- c("purple","blue","green","yellow","orange","red")
  colnames(data) <- c("x","y","z")
  data$z <- as.factor(data$z)
  levels(data$z) <- c('Planophile','Erectophile','Plagiophile','Extremophile','Spherical','Uniform')
  
  sa_plot_lue_lidf <- ggplot(data, mapping = aes(x = x, y = y, color = z)) + xlab(label_x) + ylab(label_y) +  #ggtitle(title_text) + 
    geom_point(size = 2.5) + 
    theme_bw() +
    theme(panel.border = element_rect(fill=NA, colour = "black", size=1),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          legend.title = element_text(size = 25, face = "bold", color="black"), text = element_text(face = "bold", size=15, color="black"),  legend.text = element_text(size = 20, face = "bold", color="black"),
          legend.key.height = unit(0.5, "inch"), legend.key.width = unit(0.3, "inch")) + 
    scale_color_manual(values = rhg_cols) + 
    guides(color = guide_legend(override.aes = list(size=5)))+
    coord_cartesian(ylim=c(0,lim_y),xlim = c(0, lim_x+0.001))+ scale_x_continuous(breaks=c(0.0,0.005,0.01),labels =c('0.0','0.005','0.01')) + 
    labs(color = legend_title) + 
    guides(fill = guide_colourbar(barwidth = 3, barheight = 27, ticks = FALSE))+ theme(plot.margin = unit(c(0, 0, 0, 0), "cm"))+ 
    theme(axis.text.x = element_text(face="bold", color="black",size=14, angle=0),
          axis.text.y = element_text(face="bold", color="black", size=14, angle=45),
          axis.title.x = element_text(face="bold", color="black",size=16),
          axis.title.y = element_text(face="bold", color="black",size=16),
          plot.margin = unit(c(0, 0, 0, 0.3), "cm"))
  
  
  #+
  # theme(title = element_text(size = 20, color = 'red', face = "bold"), aspect.ratio = 0.5)
  #       legend.title = element_text(size = 10, face = "bold"),
  #       legend.text = element_text(size = 10),
  #       legend.key.height = unit(1,'cm')) 
  
  
  return (sa_plot_lue_lidf)
}


#########################################
## plot scatter plot and show R2, p values,  fittiong equation across different LC type
sa_plot_other_lidf= function(data, label_x, label_y, lim_x, lim_y, title_text,legend_title){
  rhg_cols <- c("purple","blue","green","yellow","orange","red")
  colnames(data) <- c("x","y","z")
  data$z <- as.factor(data$z)
  levels(data$z) <- c('Planophile','Erectophile','Plagiophile','Extremophile','Spherical','Uniform')
  
  sa_plot_other_lidf <- ggplot(data, mapping = aes(x = x, y = y, color = z)) + xlab(label_x) + ylab(label_y ) + 
    geom_point(size = 2.5) + 
    theme_bw() +
    theme(
      panel.border = element_rect(fill=NA, colour = "black", size=1),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.title = element_text(size = 25, face = "bold", color="black"), text = element_text(size=15,face = "bold", color="black"), legend.text = element_text(size = 20, face = "bold", color="black"),
      legend.key.height = unit(0.5, "inch"), legend.key.width = unit(0.3, "inch"), axis.title.y = element_text(size = 15, face = "bold" , color="black")) + 
    scale_color_manual(values = rhg_cols) + 
    guides(fill = guide_colourbar(ticks = FALSE))+
    coord_cartesian(ylim=c(0,lim_y),xlim = c(0, lim_x)) + 
    labs(color = legend_title) +
    guides(color = guide_legend(override.aes = list(size=5))) + theme(plot.margin = unit(c(0, 0, 0, 0), "cm"))+ 
    theme(axis.text.x = element_text(face="bold", color="black",size=14, angle=0),
          axis.text.y = element_text(face="bold", color="black", size=14, angle=45),
          axis.title.x = element_text(face="bold", color="black",size=16),
          axis.title.y = element_text(face="bold", color="black",size=16),
          plot.margin = unit(c(0, 0, 0, 0.3), "cm")) 
  
  
  
  return (sa_plot_other_lidf)
}
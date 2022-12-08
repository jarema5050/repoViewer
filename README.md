
#Coding challenge - iOS
## repoViewer

Using Swift, create an application that meets these criteria:

 1. It consists of two screens: one with an element list and the other with element details after it has been selected from the list. 
 2. It downloads the elements from two APIs: 
* Bitbucket: 
https://api.bitbucket.org/2.0/repositories?fields=values.name,values.owner,values.description 
* GitHub: https://api.github.com/repositories 
3. List element consists of: repository name, user’s name and user’s avatar.
4. Details screen consists of: repository name, repository details, user’s name and user’s avatar. 
5. Elements downloaded from the Bitbucket API should be visually distinguishable from Github ones (in any way). 
6. Element list needs to have an option to turn on/off alphabetical sorting by repository name. 
7. Pagination is not required.  

Nice to have:

✅ Using an architectural pattern of your choice (MVP/MVVM/etc).  
✅ Reactive approach (RxSwift).  
✅ Handling no-network state (by means of your selection, can vary from a simple message to full offline mode).  
